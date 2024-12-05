package utp.demo.model;

public class LoginPersonalResult {
    private Integer idPersonal;
    private String rol;

    public LoginPersonalResult(Integer idPersonal, String rol) {
        this.idPersonal = idPersonal;
        this.rol = rol;
    }

    public Integer getIdPersonal() {
        return idPersonal;
    }

    public void setIdPersonal(Integer idPersonal) {
        this.idPersonal = idPersonal;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }
}