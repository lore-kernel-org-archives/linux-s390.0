From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v8 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
Date: Thu, 9 Aug 2018 17:43:36 +0200
Message-ID: <20180809154336.GB4302@osiris>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180809110645.33b20c1f.cohuck@redhat.com>
 <10a23890-5ad4-38bd-aece-def5940fec89@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10a23890-5ad4-38bd-aece-def5940fec89@linux.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 09, 2018 at 11:18:05AM -0400, Tony Krowiak wrote:
> On 08/09/2018 05:06 AM, Cornelia Huck wrote:
> >On Wed,  8 Aug 2018 10:44:14 -0400
> >Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >
> >>From: Harald Freudenberger <freude@de.ibm.com>
> >>
> >>Move all the inline functions from the ap bus header
> >>file ap_asm.h into the in-kernel api header file
> >>arch/s390/include/asm/ap.h so that KVM can make use
> >>of all the low level AP functions.
> >>
> >>Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
> >>Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >You should add your own s-o-b if you are sending on patches written by
> >others (even if it does not matter in the end, when they are merged
> >through a different path anyway.)
> 
> That's rather ironic given I was told in an internal review that I should
> not sign off on patches I did not write.

Please point the one who said that to
Documentation/process/submitting-patches.rst / Developer's Certificate of Origin

You really should sign off patches you forward, even if you did not write
them on your own.
