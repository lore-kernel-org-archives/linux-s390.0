Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
 <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
 <20190201090159.GC3770@osiris>
 <a02f611b-370c-85b3-9e3d-c7dc2462004d@linux.ibm.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Mon, 4 Feb 2019 11:06:13 +0100
MIME-Version: 1.0
In-Reply-To: <a02f611b-370c-85b3-9e3d-c7dc2462004d@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <e42e9ddb-e771-2789-727c-917ca3e176f2@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sebastian Ott <sebott@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, oberpar@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 01.02.19 16:38, Tony Krowiak wrote:
> On 2/1/19 4:01 AM, Heiko Carstens wrote:
>> On Thu, Jan 31, 2019 at 06:28:39PM -0500, Tony Krowiak wrote:
>>> On 1/30/19 1:32 PM, Sebastian Ott wrote:
>>>> On Wed, 30 Jan 2019, Tony Krowiak wrote:
>>>>> +#if IS_ENABLED(CONFIG_ZCRYPT)
>>>>> +void ap_bus_cfg_chg(void);
>>>>> +#else
>>>>> +#error "no CONFIG_ZCRYPT"
>>>>     ^
>>>> I don't think that's the right thing to do here.
>>>
>>> I'd like to leave it. If somebody edits .config
>>> and sets CONFIG_ZCRYPT=n, then the build will
>>> fail. The preprocessor error above tells them
>>> why.
>>
>> No, the kernel build should never fail if a config option is not set.
>> Also the above should be "#ifdef CONFIG_ZCRYPT".
>
> Will do.
>
>>
>> In addition (this isn't quoted unfortunately) the alternative function
>> in the header file is missing the "inline" attribute. Can you please
>> add that too?
>
> I can.
>
>>
>> static inline void ap_bus_cfg_chg(void) { }
>>
>>>>> +* A config change has happened, Force an ap bus rescan.
>>>>> +*/
>>>>> +void ap_bus_cfg_chg(void)
>>>>> +{
>>>>> +    AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
>>>>> +
>>>>> +    ap_bus_force_rescan();
>>>>> +}
>>>>> +EXPORT_SYMBOL(ap_bus_cfg_chg);
>>>>
>>>> There is no need for the export symbol - you don't call that function
>>> >from module code.
>>>> As an unrelated question, just to be sure: ap_bus.c is compiled as
>>>> built-in even with ZCRYPT=m, right?
>>>
>>> No. If you edit .config and set CONFIG_ZCRYPT=m, ap_bus.c will be built
>>> into the zcrypt.ko module. Through some other magic, the zcrypt module
>>> is loaded when linux boots.
>>
>> If that happens, then we have a build problem that needs to be
>> fixed. What exactly are you doing to get the ap code linked into the
>> zcrypt module?
>
> To tell you the truth, I don't know. The build configuration precedes my
> creating this patch by many years. I only discovered these anomalies by
> playing with the CONFIG_ZCRYPT option in response to Sebastian's
> comments. I will have to take this up with our internal IBM maintainer.
>
>>
>
As Martin already pointed out the ap bus code is statically build into the kernel
with this line in the Makefile:
  obj-$(subst m,y,$(CONFIG_ZCRYPT)) += ap.o
So CONFIG_ZCRYPT may have the value 'm' or 'y'
and this is also the reason why a simple #ifdef CONFIG_ZCRYPT does not
work, instead #if IS_ENABLED(CONFIG_ZCRYPT) has to be used.

Only the ap stuff (which is: ap_bus.o, ap_card.o and ap_queue.o) is statically
build into the kernel. The zcrypt kernel module is loaded as a dependency
when a crypto card is detected. So detecting a CEX4 forces kernel module
zcrypt_cex4.ko which forces the zcrypt.ko to insert into the kernel.
So all global functions in ap_bus.c are available when CONFIG_ZCRYPT is
enabled. However, I thought the symbol still needs an EXPORT_SYMBOL()
statement. Otherwise I should throw out all these statements.

Harald
