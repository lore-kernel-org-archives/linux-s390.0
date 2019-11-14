Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbfKNNZL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 08:25:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEDGUFY119282
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 08:25:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w97hurhx3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 08:25:08 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Thu, 14 Nov 2019 13:25:06 -0000
Date: Thu, 14 Nov 2019 14:25:00 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC 11/37] DOCUMENTATION: protvirt: Interrupt injection
In-Reply-To: <20191114140946.7bca2350.cohuck@redhat.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-12-frankja@linux.ibm.com>
        <20191114140946.7bca2350.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20191114142500.55f985b1@p-imbrenda.boeblingen.de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 14 Nov 2019 14:09:46 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 24 Oct 2019 07:40:33 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
> > Interrupt injection has changed a lot for protected guests, as KVM
> > can't access the cpus' lowcores. New fields in the state
> > description, like the interrupt injection control, and masked
> > values safeguard the guest from KVM.
> > 
> > Let's add some documentation to the interrupt injection basics for
> > protected guests.
> > 
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > ---
> >  Documentation/virtual/kvm/s390-pv.txt | 27
> > +++++++++++++++++++++++++++ 1 file changed, 27 insertions(+)
> > 
> > diff --git a/Documentation/virtual/kvm/s390-pv.txt
> > b/Documentation/virtual/kvm/s390-pv.txt index
> > 86ed95f36759..e09f2dc5f164 100644 ---
> > a/Documentation/virtual/kvm/s390-pv.txt +++
> > b/Documentation/virtual/kvm/s390-pv.txt @@ -21,3 +21,30 @@ normally
> > needed to be able to run a VM, some changes have been made in SIE
> > behavior and fields have different meaning for a PVM. SIE exits are
> > minimized as much as possible to improve speed and reduce exposed
> > guest state. +
> > +
> > +Interrupt injection:
> > +
> > +Interrupt injection is safeguarded by the Ultravisor and, as KVM
> > lost +access to the VCPUs' lowcores, is handled via the format 4
> > state +description.
> > +
> > +Machine check, external, IO and restart interruptions each can be
> > +injected on SIE entry via a bit in the interrupt injection control
> > +field (offset 0x54). If the guest cpu is not enabled for the
> > interrupt +at the time of injection, a validity interception is
> > recognized. The +interrupt's data is transported via parts of the
> > interception data +block.  
> 
> "Data associated with the interrupt needs to be placed into the
> respective fields in the interception data block to be injected into
> the guest."
> 
> ?

when a normal guest intercepts an exception, depending on the exception
type, the parameters are saved in the state description at specified
offsets, between 0xC0 amd 0xF8

to perform interrupt injection for secure guests, the same fields are
used to specify the interrupt parameters that should be injected into
the guest

> > +
> > +Program and Service Call exceptions have another layer of
> > +safeguarding, they are only injectable, when instructions have
> > +intercepted into KVM and such an exception can be an emulation
> > result.  
> 
> I find this sentence hard to parse... not sure if I understand it
> correctly.
> 
> "They can only be injected if the exception can be encountered during
> emulation of instructions that had been intercepted into KVM."
 
yes

> 
> > +
> > +
> > +Mask notification interceptions:
> > +As a replacement for the lctl(g) and lpsw(e) interception, two new
> > +interception codes have been introduced. One which tells us that
> > CRs +0, 6 or 14 have been changed and therefore interrupt masking
> > might +have changed. And one for PSW bit 13 changes. The CRs and
> > the PSW in  
> 
> Might be helpful to mention that this bit covers machine checks, which
> do not get a separate bit in the control block :)
> 
> > +the state description only contain the mask bits and no further
> > info +like the current instruction address.  
> 
> "The CRs and the PSW in the state description only contain the bits
> referring to interrupt masking; other fields like e.g. the current
> instruction address are zero."

wait state is saved too

CC is write only, and is only inspected by hardware/firmware when
KVM/qemu is interpreting an instruction that expects a new CC to be set,
and then only the expected CCs are allowed (e.g. if an instruction only
allows CC 0 or 3, 2 cannot be specified)
