From: Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC PATCH v2 10/15] cpu-model/s390: Add cpu class initialization
 routines
Date: Fri, 20 Feb 2015 10:11:55 -0800
Message-ID: <54E778EB.5050301@twiddle.net>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com> <1424183053-4310-11-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-11-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On 02/17/2015 06:24 AM, Michael Mueller wrote:
> +static inline uint64_t big_endian_bit(unsigned long nr)
> +{
> +    return 1ul << (BITS_PER_LONG - (nr % BITS_PER_LONG));
> +};

This is buggy.  NR=0 should map to 63, not 64.

> +    return !!(*ptr & big_endian_bit(nr));

Personally I dislike !! as an idiom.  Given that big_endian_bit isn't used
anywhere else, can we integrate it and change this to

static inline int test_facility(unsigned long nr, uint64_t *fac_list)
{
  unsigned long word = nr / BITS_PER_LONG;
  unsigned long be_bit = 63 - (nr % BITS_PER_LONG);
  return (fac_list[word] >> be_bit) & 1;
}


r~
