From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v1 0/2] KVM: s390: Tracing APCB changes
Date: Fri, 5 Oct 2018 12:55:51 +0200
Message-ID: <879f5959-b0c9-9bed-7178-acf217aefd53@linux.ibm.com>
References: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
 <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: david@redhat.com, linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 10/05/2018 10:31 AM, Pierre Morel wrote:
> In the first patch we define kvm_arch_crypto_set_masks,
> a new function to centralize the setup the APCB masks
> inside the CRYCB SIE satelite and add KVM_EVENT() to
> kvm_arch_crypto_set_masks and kvm_arch_crypto_clear_masks.
> 
> In the second patch we replace the vfio_ap_mdev_copy_masks()
> by the new kvm_arch_crypto_set_masks() function.
> 

FWIW I also like this version better. And accommodating for on-the
fly changes seems to be showing in the right direction anyway.

I did not look into the details but it looks good to me.

Halil
