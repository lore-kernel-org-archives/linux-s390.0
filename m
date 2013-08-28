From: Chen Gang <gang.chen@asianux.com>
Date: Wed, 28 Aug 2013 08:19:20 +0000
Subject: Re: [PATCH] s390: kernel: remove redundency checking for sysinfo_show() in "sysinfo.c"
Message-Id: <521DB288.8010700@asianux.com>
In-Reply-To: <20130828060633.GA4353@osiris>
References: <20130828060633.GA4353@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 08/28/2013 02:06 PM, Heiko Carstens wrote:
> On Wed, Aug 28, 2013 at 09:55:00AM +0800, Chen Gang wrote:
>> So in my opnion, it will be better to let all level 1 related functions
>> within "if (level >= 1) {...}" code block, that will make code clearer
>> to readers (or some members may doubt about this code).
> 
> I'm not going to apply your patch, otherwise I would have done that already.
> 

OK, I can understand.

Hmm... better to provide some reasons, or I have to 'guess'. ;-)


>> BTW: could you provide more information about why need stsi_15_1_x() be
>> in "level 1" ?
> 
> That's what the architecture says.
> You can download it here: publibfi.boulder.ibm.com/epubs/pdf/dz9zr009.pdf
> 

Firstly, it is a valuable document (at least to me, it is), thanks.


After a quick reference of it, I find the answer below:

  for "level 15":

    "level 15" is "Current-configuration-level information".
    so it should print at any valid level: "level 1, 2, and 3".
    that is just equal to "level 1"

  and for "level 1,2,3"

    "Information about level 1 (the basic machine)"
    "Information about level 2 (a logical partition)"
    "Information about level 3 (a virtual machine)"

  and for "level 4--14"

    "None; codes are reserved"

  and for "level 0":

    "level 0" is for qureying ("Current-configuration-level number")
    so "level 1" also need check level number to support "level 0".


Is it correct ?


:-)

Thanks.
-- 
Chen Gang
