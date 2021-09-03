Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA21C433F5
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 10:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31EA60F56
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 10:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349004AbhICK35 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:29:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64320 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349107AbhICK35 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Sep 2021 06:29:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183A4ZKF130523;
        Fri, 3 Sep 2021 06:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ITK+u920VAmJpflJWFp5FYBNd4sZ/DY7TDhZ84ckDLg=;
 b=AD4prqQsajt6iqEQr0aoSzP1B5Zhy6NJQwGzi9U6a/WUDQj4vl3drcNZszCkB6tqx+vf
 WgAVJOlmNTcCv3s6FHObbIm39vWC13gEB5ahGUefkJv6Vc/3/+3d1Sbr3awD5dQbtkPf
 ILrJ3PTMREuVf8lM50uuvtKrKhp9vNuCGOSHIvPZ0Qa4VxVh6J0CexB7gS9t9QZM+6ak
 uWx5rOsp67l9alFaJBzWuU2j2WTiKoP5t+sl2Zj5kJEPd+4ORYqgglVcGjJNtq5AkvK7
 BkQTqfPwfiNNTOGUgf+zWEgy2i8VS7TK9MmgPQ8evsJXC8C455q9HyCbM8atcCKt26TU PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3audm3xw24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 06:28:47 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 183A5Tq7138519;
        Fri, 3 Sep 2021 06:28:47 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3audm3xw1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 06:28:47 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183AHijV001939;
        Fri, 3 Sep 2021 10:28:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3au6q06k36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 10:28:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183ASgKD56426766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 10:28:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21DEBAE059;
        Fri,  3 Sep 2021 10:28:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B25A7AE091;
        Fri,  3 Sep 2021 10:28:41 +0000 (GMT)
Received: from sig-9-145-171-221.de.ibm.com (unknown [9.145.171.221])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 10:28:41 +0000 (GMT)
Message-ID: <9e4780da8c899f2272923cc4fe72814891845226.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/io: Fix ioremap and iounmap undefinded issue for
 s390
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 03 Sep 2021 12:28:41 +0200
In-Reply-To: <CAAfSe-v0DbOS5p7nF0db4SdTrsy28gJNdW93ds4capVxuUO1xw@mail.gmail.com>
References: <20210903075641.2807623-1-zhang.lyra@gmail.com>
         <20210903080316.2808017-1-zhang.lyra@gmail.com>
         <b4a5f322d035d75c97abf2aaa19d033adc68527d.camel@linux.ibm.com>
         <CAAfSe-v0DbOS5p7nF0db4SdTrsy28gJNdW93ds4capVxuUO1xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ObhSSqpBqzhVbpS82xOM820cvLillA_z
X-Proofpoint-GUID: ivWiYtXieABP_70wQPllX2Ff_kW85VhZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_02:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030061
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 2021-09-03 at 17:40 +0800, Chunyan Zhang wrote:
> On Fri, 3 Sept 2021 at 16:24, Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > On Fri, 2021-09-03 at 16:03 +0800, Chunyan Zhang wrote:
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > 
> > > There would not be ioremap and iounmap implementations if CONFIG_PCI is
> > > not set for s390, so add default declarations of these two functions
> > > for the case to avoid 'undefined reference' issue.
> > > 
> > > Fixes: 71ba41c9b1d9 ("s390/pci: provide support for MIO instructions")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > > The issue was reported from https://lkml.org/lkml/2021/8/1/18
> > 
> > Thanks for the patch but I'm a little skeptical about adding
> > ioremap()/iounmap() stubs that don't do anything useful and on top ofn
> > that would do so silently.
> > 
> > In the above discussion you said that TIMER_OF should depend on
> > HAS_IOMEM. In arch/s390/Kconfig HAS_IOMEM is set if and only if
> > CONFIG_PCI is set so that sounds to me like it would prevent the
> > undefined reference without the risk of someone trying to use io*map()
> > without CONFIG_PCI.
> 
> Humm... you can ignore my reply on that time, I later found that's not
> correct :)
> 
> TIMER_OF would be selected by other configs and it seems not able to
> depends on HAS_IOMEM, unless all configs which select TIMER_OF depend
> on HAS_IOMEM, that would be a big change.

Hmm I already see a lot of the options in drivers/clocksource/Kconfig
depend on HAS_IOMEM and drivers/clocksource/timer-of.c definitely calls
iounmap() so wouldn't that be the logical change even if it is bigger? 

> 
> Actually HAS_IOMEM is set as default on other architectures, but not
> for s390 which redefined it.

Yes because most architectures always have IOMEM and io*map() functions
I believe. s390 is an exception here as the mainframe native
functionality all works without MMIO and you can run a fully functional
system including networking and block devices without any MMIO, PCI and
without ioremap()/iounmap().

> 
> > At the very least I think the functions should do a WARN_ONCE() but
> > then we have the same situation as discussed below with Linus making it
> > pretty clear that he prefers these cases to be compile time checked:
> 
> Ok, if I understand correctly, if io*map is not implemented for some
> case, there should be a *compile-time* error rather than adding a stub
> function to make this kind of errors disappeared.
> 
> Please correct me if I missed something.

Ideally not a compile time error but a compile time flag such as a
Kconfig option that would make sure that if HAS_IOMEM isn't set we
don't get drivers compiled which depend on working io*map(). After all
these drivers will surely not be functional.

> 
> Thanks,
> Chunyan
> 
> > https://lkml.org/lkml/2021/7/2/511
> > 
> > 
> > > ---
> > >  arch/s390/include/asm/io.h | 15 ++++++++++++---
> > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
> > > index e3882b012bfa..9438370c6445 100644
> > > --- a/arch/s390/include/asm/io.h
> > > +++ b/arch/s390/include/asm/io.h
> > > @@ -23,11 +23,8 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
> > >  #define IO_SPACE_LIMIT 0
> > > 
> > > 
> > .. snip ..
> > 

