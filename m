From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH v2 13/15] cpu-model/s390: Add processor property routines
Date: Fri, 20 Feb 2015 15:03:30 +0100
Message-ID: <54E73EB2.6050700@suse.de>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com> <1424183053-4310-14-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-14-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>



On 17.02.15 15:24, Michael Mueller wrote:
> This patch implements the functions:
> 
> - s390_get_proceccor_props()
> - s390_set_proceccor_props()
> 
> They can be used to request or retrieve processor related information from an accelerator.
> That information comprises the cpu identifier, the ICB value and the facility lists.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>

Hrm, I still seem to miss the point of this interface. What do you need
it for?


Alex
