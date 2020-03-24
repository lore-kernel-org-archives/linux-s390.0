Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727657AbgCXTLh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 15:11:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OJ2qrR072327
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 15:11:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yynky66yq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 15:11:36 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 24 Mar 2020 19:11:31 -0000
Date: Tue, 24 Mar 2020 20:11:28 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: s390: removal of hibernate support
References: <20200323181245.GJ4288@osiris>
 <CAJZ5v0hzf=kQBcR=K2KL1kEVtA6oLPtLDaeeaVuWMPsXomhJHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hzf=kQBcR=K2KL1kEVtA6oLPtLDaeeaVuWMPsXomhJHw@mail.gmail.com>
Message-Id: <20200324191128.GA3822@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, linux-s390@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>

Hi Rafael,

> On Mon, Mar 23, 2020 at 7:12 PM Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> > we are going to remove hibernate support on s390, since it is
> > - broken since many years
> > - there is no real use case which justifies keeping and maintaining
> >   the code
> >
> > See also https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=394216275c7d503d966317da9a01ad6626a6091d
> >
> > This in turn allows also to remove s390 specific hooks in generic
> > power management code (see patch below). The patch below is currently
> > also on the same features branch.
> > I silently assume(d) that you don't mind to get rid of otherwise dead
> > code, or do you have any objections?
> >
> > From 086b2d78375cffe58f5341359bebec0650793811 Mon Sep 17 00:00:00 2001
> > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Date: Wed, 18 Mar 2020 20:55:20 +0100
> > Subject: [PATCH] PM: remove s390 specific callbacks
> >
> > ARCH_SAVE_PAGE_KEYS has been introduced in order to be able to save
> > and restore s390 specific storage keys into a hibernation image.
> > With hibernation support removed from s390 there is no point in
> > keeping the callbacks.
> >
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> 
> Can I take this patch or would it be better to route it differently?

The patch is already on the s390 features branch and is supposed to be
part of the first pull request for the next merge window (actually the
patch is already in linux-next).
So I'd say the easiest thing would be to route it through the s390 tree.
