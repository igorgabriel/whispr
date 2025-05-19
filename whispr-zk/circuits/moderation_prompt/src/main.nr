use std::hash::poseidon;

global SADNESS: Field = Field::from(0);
global ANXIETY: Field = Field::from(1);
global ANGER: Field = Field::from(2);
global PROMPT_LEN: u32 = 64;

fn main(prompt_hash_input: [Field; PROMPT_LEN], emotion: Field, risk_flag: Field) {
    let prompt_hash: Field =
        10235324557001578325432759324202516551848898181889185265008640117344586426929;

    // 1) Recalcula o hash do prompt usando poseidon hash_2 iterativo
    let mut state: Field = Field::from(0);
    for i in 0..PROMPT_LEN {
        state = poseidon::bn254::hash_2([state, prompt_hash_input[i]]);
    }

    // 2) Verifica que bate com o hash publico
    assert(state == prompt_hash);

    // 3) Estamos em modo critico
    assert(risk_flag == Field::from(1));

    // Calcula (emotion - SADNESS)*(emotion - ANXIETY)*(emotion - CALM) == 0
    let diff1 = emotion - SADNESS;
    let diff2 = emotion - ANXIETY;
    let diff3 = emotion - ANGER;
    let prod = diff1 * diff2 * diff3;
    assert(prod == Field::from(0));
}
