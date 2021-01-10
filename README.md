# Prescribr
Prescribr is an app that lets you manage the drugs a doctor describes to his patient.  
Many drugs have negative interactions when using them in combination. When you take just two different drugs, the interactions are quiet easy to determine by memory.  
When using 4 or more drugs this gets exponentially difficult. When a doctor makes a mistake in determining if the medication he wants to prescribe will be harmful or not, this can be a costly one, human lives are at stake.  
  
With Prescribr this process gets simplified a lot, you just fill in the prescribed drugs for the patient and the app will visually show if the combination could cause problems or not. 

## Login credentials
The premade profile for the app:
```
username: doctor@pepper.com
password: P@ssword1
```

## Pods
For this project I use Pods to add dependencies to my project, the used Podfile is listed below.

```bash
target 'Prescribr' do
  use_frameworks!
  
# Pods for Prescribr

pod 'Alamofire', '~>5.2'
pod 'Toast-Swift', '~>5.0.0'
pod 'ModelMapper'
pod 'PaddingLabel', '1.2'

end
```

## Knows issues
There are still some issues in the app. Most of the issues have been solved in other components of the app, demonstrating that I do know how to fix them but due to time limitations I was not able to fix them all.

- When creating a new user the new user isn't displayed in the user list
  - **solve:** This needs a delegate to observe the user
- When adding a drug to a patient it isnt persisted
  - **solve:** adding a second delegate for the patient list
