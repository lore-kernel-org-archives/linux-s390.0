Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726057AbfKNKL2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 05:11:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEAA9c6064134
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:11:26 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w92bjnh03-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:11:24 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Nov 2019 10:11:21 -0000
Subject: Re: [PATCH v1 4/4] s390x: Testing the Subchannel I/O read
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-5-git-send-email-pmorel@linux.ibm.com>
 <20191113140539.4d153d5f.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 14 Nov 2019 11:11:18 +0100
MIME-Version: 1.0
In-Reply-To: <20191113140539.4d153d5f.cohuck@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Message-Id: <802c298d-d2da-83c4-c222-67bb78131988@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com


On 2019-11-13 14:05, Cornelia Huck wrote:
> On Wed, 13 Nov 2019 13:23:19 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> This simple test test the I/O reading by the SUB Channel by:
>> - initializing the Channel SubSystem with predefined CSSID:
>>    0xfe000000 CSSID for a Virtual CCW
> 0 should be fine with recent QEMU versions as well, I guess?
Right


>
>>    0x00090000 SSID for CCW-PONG
> subchannel id, or subchannel set id?

hum, only part of, I had SSID (Subchannel Set ID) 4 (a.k.a m bit) + Bit=20
47=EF=BF=BD =3D1

But as you said, I can use CSSID 0 and m =3D 0 which makes:

Subsystem Identification word =3D 0x00010000


>
>> - initializing the ORB pointing to a single READ CCW
> Out of curiosity: Would using a NOP also be an option?

It will work but will not be handled by this device, css.c intercept it=20
in sch_handle_start_func_virtual.

AFAIU If we want to have a really good testing environment, for driver=20
testing for exemple, then it would be interesting to add a new=20
do_subchannel_work callback like do_subchannel_work_emulation along with=20
the _virtual and _paththrough variantes.

Having a dedicated callback for emulation, we can answer to any CSS=20
instructions and SSCH commands, including NOP and TIC.

My goal here was to quickly develop a device answering to some basic=20
READ/WRITE command to start memory transfers from inside a guest without=20
Linux and without implementing VIRTIO in KVM tests.



>
>> - starts the STSH command with the ORB
> s/STSH/SSCH/ ?

:) yes, thanks


>
>> - Expect an interrupt
>> - writes the read data to output
>>
>> The test implements lots of traces when DEBUG is on and
>> tests if memory above the stack is corrupted.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h      | 244 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   lib/s390x/css_dump.c | 141 +++++++++++++++++++++++++++++
>>   s390x/Makefile       |   2 +
>>   s390x/css.c          | 222 +++++++++++++++++++++++++++++++++++++++++++=
+++
>>   s390x/unittests.cfg  |   4 +
>>   5 files changed, 613 insertions(+)
>>   create mode 100644 lib/s390x/css.h
>>   create mode 100644 lib/s390x/css_dump.c
>>   create mode 100644 s390x/css.c
>>
>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>> new file mode 100644
>> index 0000000..a7c42fd
>> --- /dev/null
>> +++ b/lib/s390x/css.h
> (...)
>
>> +static inline int rsch(unsigned long schid)
> I don't think anyone has tried rsch with QEMU before; sounds like a
> good idea to test this :)

With an do_subchannel_work_emulation() callback?


>
>> +{
>> +	register unsigned long reg1 asm("1") =3D schid;
>> +	int ccode;
>> +
>> +	asm volatile(
>> +		"	rsch\n"
>> +		"	ipm	%0\n"
>> +		"	srl	%0,28"
>> +		: "=3Dd" (ccode)
>> +		: "d" (reg1)
>> +		: "cc");
>> +	return ccode;
>> +}
>> +
>> +static inline int rchp(unsigned long chpid)
> Anything useful we can test here?

Not for now.

I certainly can reduce the size of the file by removing the unused CSS=20
instructions calls.

...snip...
> +
>> +static void enable_io_irq(void)
>> +{
>> +	set_io_irq_subclass_mask(0x00000000ff000000);
> So, you always enable all iscs? Maybe add a comment?

OK, is just a lazy option to get IRQ for this test.

Right, I add a comment.


>
>> +	set_system_mask(PSW_PRG_MASK >> 56);
>> +}
>> +
>> +void handle_io_int(sregs_t *regs)
>> +{
>> +	int ret =3D 0;
>> +
>> +	DBG("IO IRQ: subsys_id_word=3D%08x", lowcore->subsys_id_word);
>> +	DBG("......: io_int_parm   =3D%08x", lowcore->io_int_param);
>> +	DBG("......: io_int_word   =3D%08x", lowcore->io_int_word);
>> +	ret =3D tsch(lowcore->subsys_id_word, &irb);
>> +	dump_irb(&irb);
>> +	if (ret)
>> +		DBG("......: tsch retval %d", ret);
>> +	DBG("IO IRQ: END");
>> +}
>> +
>> +static void set_schib(struct schib *sch)
>> +{
>> +	struct pmcw *p =3D &sch->pmcw;
>> +
>> +	p->intparm =3D 0xdeadbeef;
>> +	p->devnum =3D 0xc0ca;
>> +	p->lpm =3D 0x80;
>> +	p->flags =3D 0x3081;
> Use #defines instead of magic numbers?

OK


>
>> +	p->chpid[7] =3D 0x22;
>> +	p->pim =3D 0x0f;
>> +	p->pam =3D 0x0f;
>> +	p->pom =3D 0x0f;
>> +	p->lpm =3D 0x0f;
>> +	p->lpum =3D 0xaa;
>> +	p->pnom =3D 0xf0;
>> +	p->mbi =3D 0xaa;
>> +	p->mbi =3D 0xaaaa;
> Many of these fields are not supposed to be modifiable by the program
> -- do you want to check what you get back after msch?
>
> Also, you set mbi twice ;) (And for it to actually have any effect,
> you'd have to execute SET CHANNEL MONITOR, no?)

Yes, it was for me to check what happens but I should remove most of=20
these field initialization.

As you said they are not modifiable by the program.

Will clean this.


>
>
>> +}
>> +
>> +static void css_enable(void)
>> +{
>> +	int ret;
>> +
>> +	ret =3D stsch(CSSID_PONG, &schib);
>> +	if (ret)
>> +		DBG("stsch: %x\n", ret);
>> +	dump_schib(&schib);
>> +	set_schib(&schib);
>> +	dump_schib(&schib);
>> +	ret =3D msch(CSSID_PONG, &schib);
>> +	if (ret)
>> +		DBG("msch : %x\n", ret);
>> +}
>> +
>> +/* These two definitions are part of the QEMU PONG interface */
>> +#define PONG_WRITE 0x21
>> +#define PONG_READ  0x22
> Ah, so it's not a plain read/write, but a specialized one? Mention that
> in the patch description?
>
>> +
>> +static int css_run(int fake)
>> +{
>> +	struct orb *p =3D orb;
> I'd maybe call that variable 'orb' instead; at a glance, I was confused
> what you did with the pmcw below, until I realized that it's the orb :)

OK, is clearly better to use orb.


Thanks,

Pierre


--=20
Pierre Morel
IBM Lab Boeblingen
