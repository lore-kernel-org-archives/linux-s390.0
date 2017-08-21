From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] KVM: s390: sthyi: fix specification exception
 detection
Date: Mon, 21 Aug 2017 15:09:18 +0200
Message-ID: <20170821150918.4df5d2d5.cohuck@redhat.com>
References: <1503318465-19013-1-git-send-email-borntraeger@de.ibm.com>
        <1503318465-19013-3-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503318465-19013-3-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 21 Aug 2017 14:27:45 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> sthyi should only generate a specification exception if the function
> code is zero and the response buffer is not on a 4k boundary.
> 
> The current code would also test for unknown function codes if the
> response buffer, that is currently only defined for function code 0,
> is not on a 4k boundary and incorrectly inject a specification
> exception instead of returning with condition code 3 and return code 4
> (unsupported function code).
> 
> Fix this by moving the boundary check.
> 
> Fixes: 95ca2cb57985 ("KVM: s390: Add sthyi emulation")
> Cc: <stable@vger.kernel.org> # 4.8+
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/sthyi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
