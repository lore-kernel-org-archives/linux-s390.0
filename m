From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH] trivial treewide: Convert dev_set_uevent_suppress
 argument to bool
Date: Fri, 2 Sep 2016 08:59:47 -0700
Message-ID: <7405780b-3dcd-3c6a-9268-3fac6f3a7b3f@sandisk.com>
References: <699402ce4c488995b4ddabff0f3b262851cf56ac.1472760613.git.joe@perches.com>
 <BLUPR02MB1683CF8A399E613B8C209C3B81E50@BLUPR02MB1683.namprd02.prod.outlook.com>
 <1472777516.4176.149.camel@perches.com>
 <BLUPR02MB1683E6A75F29015CBCAD804D81E50@BLUPR02MB1683.namprd02.prod.outlook.com>
 <1472830862.6758.7.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <1472830862.6758.7.camel@perches.com>
Sender: linux-block-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Joe Perches <joe@perches.com>, Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>, Jiri Kosina <trivial@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 09/02/2016 08:41 AM, Joe Perches wrote:
> On Fri, 2016-09-02 at 13:41 +0000, Bart Van Assche wrote:
>> On 09/01/16 17:51, Joe Perches wrote:
>>> On Fri, 2016-09-02 at 00:47 +0000, Bart Van Assche wrote:
>>>> On 09/01/16 13:11, Joe Perches wrote:
>>>>> Assigning an int to a bitfield:1 can lose precision.
>>>>> Change the caller argument uses from 1/0 to true/false.
>>>> Can you clarify how assigning 0 or 1 to a one-bit bitfield can cause a
>>>> loss of precision?
>>> There are no existing defects.
>>> Using 1/0 is not a loss of precision, it's just
>>> changing to use bool avoids potential errors and
>>> promotes consistency.
>>> Other uses of this function already use true/false.
>> In the patch description you refer to loss of precision. However, your
>> patch does not address any loss of precision issues. So I think that the
>> patch description is misleading and could be made more clear.
>
> I tend towards terse being better than verbose.
> The original patch description says
>
> "no change to objects"
>
> What would you suggest?

Hello Joe,

How about the following:

dev_set_uevent_suppress() expects a boolean as second argument. Make 
this clear by passing true/false instead of 1/0 as the second argument.

Bart.
