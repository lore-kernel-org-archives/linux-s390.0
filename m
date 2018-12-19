From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio-ccw: diag 500 may return a negative cookie
Date: Wed, 19 Dec 2018 11:06:11 +0100
Message-ID: <20181219110611.66c7b18b.cohuck@redhat.com>
References: <20181218132034.14863-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181218132034.14863-1-cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 18 Dec 2018 14:20:34 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> If something goes wrong in the kvm io bus handling, the virtio-ccw
> diagnose may return a negative error value in the cookie gpr.
> 
> Document this.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> Even if the virtio spec is the correct place to specify what diag 500
> subcode 3 does, we also should mention here that the cookie may be
> an error.
> 
> ---
>  Documentation/virtual/kvm/s390-diag.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virtual/kvm/s390-diag.txt b/Documentation/virtual/kvm/s390-diag.txt
> index 48c4921794ed..7c52e5f8b210 100644
> --- a/Documentation/virtual/kvm/s390-diag.txt
> +++ b/Documentation/virtual/kvm/s390-diag.txt
> @@ -68,7 +68,8 @@ Subcode 3 - virtio-ccw notification
>      identifier, it is ignored.
>  
>      After completion of the DIAGNOSE call, general register 2 may contain
> -    a 64bit identifier (in the kvm_io_bus cookie case).
> +    a 64bit identifier (in the kvm_io_bus cookie case), or a negative
> +    error value, if an internal error occurred.
>  
>      See also the virtio standard for a discussion of this hypercall.
>  

Queued.
