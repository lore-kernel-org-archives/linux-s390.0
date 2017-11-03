From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 19/19] s390/facilities: enable AP facilities needed by guest
Date: Fri, 3 Nov 2017 09:49:46 +0100
Message-ID: <718086fa-9f9e-e474-371e-cf0a89f5460c@de.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-20-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171016112510.39e9c330@mschwideX1>
 <3e836f59-3ef1-57d8-d6df-b66011c173c4@de.ibm.com>
 <af1bb867-f9a0-458b-b7b2-c0bb9456eb7f@linux.vnet.ibm.com>
 <OF182217F7.6A47A64E-ON002581CD.002BCF58-C12581CD.002D4127@notes.na.collabserv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF182217F7.6A47A64E-ON002581CD.002BCF58-C12581CD.002D4127@notes.na.collabserv.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Harald Freudenberger <FREUDE@de.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, heicars2@linux.vnet.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, borntrAE@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 11/03/2017 09:14 AM, Harald Freudenberger wrote:
> I talked with the firmware guys about this.
> The answer is that the AP 3 instructions (NQAP, DQAP, PQAP) are always available.

That is true for basic mode and LPAR, but certainly not for z/VM or KVM guests.


> Tony is right with the facility bits.
> facility bit 15 tells if the T bit is supported with the PQAP(TAPQ) subcommand,
> facility bit 12 tells if the PQAP(QCI) subcommand is available.
> 
> As far as I could discover the AP instructions where optional on some older machines.
> This may be the reason why zVM throws an exception if there is no AP device assigned.
> However, for all machines still in service the AP instructions are available at al time.

We have to distinguish LPARs and 2nd level guests under KVM/z/VM. For those 2nd level
guests there are configurations out there TODAY that do not support PQAP and friends.
