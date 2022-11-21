plugins {
    id("java")
}

group = "de.baaasty"
version = "1.0-SNAPSHOT"

tasks {
    compileJava {
        options.encoding = "UTF-8"
    }
}

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(17))
    }
    withSourcesJar()
    withJavadocJar()
}

repositories {
    mavenCentral()
}

dependencies {

}