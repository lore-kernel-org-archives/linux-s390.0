Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64645C433F5
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 10:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A65160698
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 10:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347864AbhICKw4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:52:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235081AbhICKwz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Sep 2021 06:52:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183AYlgt065503;
        Fri, 3 Sep 2021 06:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=2wI7/uC69HAKY2YS1ZHhwaV74lLPkFZeBaJdvdBPJGE=;
 b=sM8vjxwsXve4uBde7CuBR9f/cv7F6bcDD2dVHiyCf/vW2x/M+M4Dv1FB/ztQi+UAv2zC
 AGtUjzmRA4VSxFDVzmUHQp9urETmNyIlZH+uFx+3wHgDmS/sIdbUP9rPJ86Ju9LofdXl
 bNi/vh+AG47AM/vEwvMLOetQN9AUnwQQKYNoGjZbRlMYRsIPWMz7DkgCaFnjlub+9IZc
 fKINsPRGvuKsk8+RV58VcDW+CtAK4Ml5pIV3X4s79rF0iQYlr5eMyG1kiNpWZ9wY0HdK
 H6TYGuvfpVuHoRg/MGi6EW04utCCqsRPdHSYefgP7H8tktdzRO5HXsVCjejruQ7odDpe FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3auj318a10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 06:51:44 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 183AcGkX088394;
        Fri, 3 Sep 2021 06:51:44 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3auj318a05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 06:51:44 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183AliJt028023;
        Fri, 3 Sep 2021 10:51:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3au6q06ts5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 10:51:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183ApdgS54657362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 10:51:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 031AB4C044;
        Fri,  3 Sep 2021 10:51:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92F594C088;
        Fri,  3 Sep 2021 10:51:38 +0000 (GMT)
Received: from osiris (unknown [9.145.159.114])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  3 Sep 2021 10:51:38 +0000 (GMT)
Date:   Fri, 3 Sep 2021 12:51:37 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390/io: Fix ioremap and iounmap undefinded issue for
 s390
Message-ID: <YTH+OVMeZo4GlOlg@osiris>
References: <20210903075641.2807623-1-zhang.lyra@gmail.com>
 <20210903080316.2808017-1-zhang.lyra@gmail.com>
 <b4a5f322d035d75c97abf2aaa19d033adc68527d.camel@linux.ibm.com>
 <CAAfSe-v0DbOS5p7nF0db4SdTrsy28gJNdW93ds4capVxuUO1xw@mail.gmail.com>
 <9e4780da8c899f2272923cc4fe72814891845226.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4780da8c899f2272923cc4fe72814891845226.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F4wZ4QMsQy6LAM7hJXEAEWFik1uASHKC
X-Proofpoint-ORIG-GUID: 8dTVrKUX_J0MphIu3gMEMdRb7yUJS3OM
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_02:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=779
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030064
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Sep 03, 2021 at 12:28:41PM +0200, Niklas Schnelle wrote:
> On Fri, 2021-09-03 at 17:40 +0800, Chunyan Zhang wrote:
> > On Fri, 3 Sept 2021 at 16:24, Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > On Fri, 2021-09-03 at 16:03 +0800, Chunyan Zhang wrote:
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > 
> > > > There would not be ioremap and iounmap implementations if CONFIG_PCI is
> > > > not set for s390, so add default declarations of these two functions
> > > > for the case to avoid 'undefined reference' issue.
> > > > 
> > > > Fixes: 71ba41c9b1d9 ("s390/pci: provide support for MIO instructions")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > > The issue was reported from https://lkml.org/lkml/2021/8/1/18
...
> > Actually HAS_IOMEM is set as default on other architectures, but not
> > for s390 which redefined it.
> 
> Yes because most architectures always have IOMEM and io*map() functions
> I believe. s390 is an exception here as the mainframe native
> functionality all works without MMIO and you can run a fully functional
> system including networking and block devices without any MMIO, PCI and
> without ioremap()/iounmap().
> 
> > 
> > > At the very least I think the functions should do a WARN_ONCE() but
> > > then we have the same situation as discussed below with Linus making it
> > > pretty clear that he prefers these cases to be compile time checked:
> > 
> > Ok, if I understand correctly, if io*map is not implemented for some
> > case, there should be a *compile-time* error rather than adding a stub
> > function to make this kind of errors disappeared.
> > 
> > Please correct me if I missed something.
> 
> Ideally not a compile time error but a compile time flag such as a
> Kconfig option that would make sure that if HAS_IOMEM isn't set we
> don't get drivers compiled which depend on working io*map(). After all
> these drivers will surely not be functional.

Please note that Arnd Bergmann started to work on that:
https://lkml.org/lkml/2021/7/5/286

However, as far as I can tell, there is nothing like that in
linux-next currently.

Arnd, are you still working on this?
