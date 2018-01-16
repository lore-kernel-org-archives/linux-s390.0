From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] vfio-ccw: update documentation
Date: Tue, 16 Jan 2018 17:17:08 +0100
Message-ID: <5a99b7e2-3cce-c92d-f1d8-1469a334ff6d@linux.vnet.ibm.com>
References: <20180115104353.27413-1-cohuck@redhat.com>
 <20180115104353.27413-2-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180115104353.27413-2-cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, borntraeger@de.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 01/15/2018 11:43 AM, Cornelia Huck wrote:
> The vfio-ccw documentation comes from the cover letter of the
> original patch submission, which shows in some parts. Give it some
> love; in particular:
> 
> - Remove/rework statements that make sense in a cover letter, but not
>   in regular documentation.
> - Fix some typos.
> - Describe the current limitations in more detail.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

The changes look sane and definitively improve on what we have
right now. Acked by me if you like.

When we are at the limitations, the prefetch story seems to be
still missing. IMHO it's the most important limitation.

Regards,
Halil
