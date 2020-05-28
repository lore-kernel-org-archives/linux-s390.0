Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387597AbgE1KFu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 May 2020 06:05:50 -0400
Date: Thu, 28 May 2020 12:05:40 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/pci: Log new handle in clp_disable_fh()
Message-ID: <your-ad-here.call-01590660340-ext-2669@work.hours>
References: <20200522183922.5253-1-ptesarik@suse.com>
 <20200528110813.7eb1fc1f@ezekiel.suse.cz>
 <595c993e-0be4-3164-2498-b915c3fc9726@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <595c993e-0be4-3164-2498-b915c3fc9726@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Petr Tesarik <ptesarik@suse.com>, linux-s390@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:01:45PM +0200, Pierre Morel wrote:
> 
> On 2020-05-28 11:08, Petr Tesarik wrote:
> > Hi all,
> > 
> > just a gentle ping.
> > 
> > If the current behaviour (logging the original handle) was intended,
> > then it was worth mentioning in the commit message for 17cdec960cf77,
> > which made the change, but since that's no longer an option, I'd be
> > happy with an explanation in email.
> > 
> > Petr T
> > 
> > On Fri, 22 May 2020 20:39:22 +0200
> > Petr Tesarik <ptesarik@suse.com> wrote:
> > 
> > > After disabling a function, the original handle is logged instead of
> > > the disabled handle.
> 
> Hi Petr,
> 
> Sorry for the delay, no doubt, you are right, the fh in zpci_dbg is the old
> one and we should use the one in the zdev struct.
> 
> Thanks,
> Pierre
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

Applied, thanks
