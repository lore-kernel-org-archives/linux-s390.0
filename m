From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 22 Nov 2018 13:37:24 +0000
Subject: Re: [PATCH 22/23] zfcp: drop default switch case which might paper over missing case
Message-Id: <cfa825ec-0cb9-3f1d-3280-ebedcdf39b9c@linux.ibm.com>
In-Reply-To: <09c3dbd1-9d2e-8bf1-06e2-97880dc022e7@suse.de>
References: <09c3dbd1-9d2e-8bf1-06e2-97880dc022e7@suse.de>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/16/2018 12:22 PM, Hannes Reinecke wrote:
> On 11/8/18 3:44 PM, Steffen Maier wrote:
>> would now
>> suppress helpful -Wswitch compiler warnings when building with W=1 

>> But then again, only with W=1 we would notice unhandled enum cases.

that's the only caveat

>> Without the default cases and a missed unhandled enum case, the code
>> might perform unforeseen things we might not want...

this would be a bug that needs fixing

>> As of today, we never run through the removed default case,
>> so removing it is no functional change.
>> In the future, we never should run through a default case but

>> introduce the necessary specific case(s) to handle new functionality.

that's the fix

>> diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
>> index b2845c5b8106..9345fed3bb37 100644
>> --- a/drivers/s390/scsi/zfcp_erp.c
>> +++ b/drivers/s390/scsi/zfcp_erp.c
>> @@ -151,9 +151,6 @@ static enum zfcp_erp_act_type zfcp_erp_handle_failed(
>> ����������������� adapter, ZFCP_STATUS_COMMON_ERP_FAILED);
>> ��������� }
>> ��������� break;
>> -��� default:
>> -������� need = 0;
>> -������� break;
>> ����� }
>> ����� return need;
>>
> If you 'should' not run through this code path, doesn't it warrant a 
> WARN_ON() or something?

#include <stdio.h>
enum foo { A, B };
int main(int argc, char *argv[]) {
	enum foo f = argc - 1;
	switch (f) {
	case A: printf("A\n"); break;
	case B: printf("B\n"); break;
	default: printf("default\n"); break;
	}
	return 0;
}

$ gcc -Wswitch -Wall -g -o Wswitch Wswitch.c

Removing case B (while keeping default:) does not warn on build.
Removing case B and default: nicely warns on build.

Hopefully I haven't missed anything. From above, I conclude:

A runtime check would require the introduction of a default case.
Adding a default case would trade a static build warning for a runtime 
WARN_ON(_ONCE) which only appears if one manages to get the code run 
into the default case that should not happen.

I find the static build warning more helpful for future extensions 
adding more value(s) to the enum. Without a default case, we always 
getting a build warning for missing switch cases.

-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
