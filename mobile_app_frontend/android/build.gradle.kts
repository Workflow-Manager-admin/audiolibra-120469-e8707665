buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.2.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.22")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

tasks.register("clean", Delete::class) {
    delete(rootProject.layout.buildDirectory)
}

// Enable build cache for all projects
allprojects {
    buildscript {
        configurations.all {
            resolutionStrategy {
                // Cache dynamic versions for 10 minutes
                cacheDynamicVersionsFor(10, "minutes")
                // Cache changing modules for 4 hours
                cacheChangingModulesFor(4, "hours")
            }
        }
    }
}
