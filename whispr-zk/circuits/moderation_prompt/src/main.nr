use std::hash::poseidon;

// Emoções permitidas
const SADNESS: Field = Field::from(0);
const ANXIETY: Field = Field::from(1);
const ANGER:    Field = Field::from(2);

fn main(
    prompt_hash_input: Field,      // hash do prompt já calculado off-chain
    emotion:           Field,      // 0, 1 ou 2
    risk_flag:         Field,      // deve ser 1
    public prompt_hash: Field      // o hash de referência já aprovado
) {
    // 1) Verifica que o cliente usou exatamente o prompt aprovado
    assert(prompt_hash_input == prompt_hash);

    // 2) Estamos em modo crítico
    assert(risk_flag == Field::one());

    // 3) Emoção permitida
    let is_sad  = emotion == SADNESS;
    let is_anx  = emotion == ANXIETY;
    let is_calm = emotion == CALM;
    assert(is_sad || is_anx || is_calm);
}
