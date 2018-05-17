From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 01/13] KVM: s390: Interface to test whether APXA
 installed
Date: Thu, 17 May 2018 11:44:21 +0200
Message-ID: <20180517114421.5f19142f.cohuck@redhat.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1525705912-12815-2-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180516122116.4c3b10a1.cohuck@redhat.com>
        <20e26cf4-84fe-b681-15e9-59bc113a3828@linux.vnet.ibm.com>
        <637083a9-49ea-b6e3-604a-58528dfe5aaf@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <637083a9-49ea-b6e3-604a-58528dfe5aaf@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 17 May 2018 11:11:41 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 16.05.2018 12:45, Tony Krowiak wrote:
> > On 05/16/2018 06:21 AM, Cornelia Huck wrote:  
> >> On Mon,  7 May 2018 11:11:40 -0400
> >> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >>  
> >>> Relocates an existing static function that tests whether
> >>> the AP extended addressing facility (APXA) is installed on
> >>> the linux host. The primary reason for relocating this
> >>> function is because a new compilation unit (arch/s390/kvm/kvm-ap.c)
> >>> is being created to contain all of the interfaces and logic
> >>> for configuring an AP matrix for a KVM guest. Some of its
> >>> functions will also need to determine whether APXA is installed,
> >>> so, let's go ahead and relocate this static function as a
> >>> public interface in kvm-ap.c.
> >>>
> >>> Notes:
> >>> ----
> >>> 1. The interface to determine whether APXA is installed on the linux
> >>>     host the information returned from the AP Query Configuration
> >>>     Information (QCI) function. This function will not be available
> >>>     if the AP instructions are not installed on the linux host, so a check
> >>>     will be included to verify that.
> >>>
> >>> 2. Currently, the AP bus interfaces accessing the AP instructions will
> >>>     not be accessible if CONFIG_ZCRYPT=n, so the relevant code will be
> >>>     temporarily contained in the new arch/s390/kvm/kvm-ap.c file until
> >>>     the patch(es) to statically build the required AP bus interfaces are
> >>>     available.  
> >> Any ETA for those interfaces? Would be nice if we could avoid
> >> introducing temporary interfaces (but I'm certainly not opposing this
> >> patch).  
> >
> > I'll check with the developer.  
> The proposal is out on the internal mailing list. I'd like to release it (internal) tomorrow or start
> next week. Already talked with Christian about this because we need to align it somehow with
> kvm and s390 kernel development.

Great, thanks for the update!
