From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [qemu-s390x] [PATCH v2 4/5] s390/cio: export hsch
 to modules
Date: Tue, 22 Jan 2019 16:21:24 +0100
Message-ID: <20190122162124.43d08692@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-5-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190121110354.2247-5-cohuck@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 21 Jan 2019 12:03:53 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> The vfio-ccw code will need this, and it matches treatment of ssch
> and csch.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

;)

> ---
>  drivers/s390/cio/ioasm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/cio/ioasm.c b/drivers/s390/cio/ioasm.c
> index 14d328338ce2..08eb10283b18 100644
> --- a/drivers/s390/cio/ioasm.c
> +++ b/drivers/s390/cio/ioasm.c
> @@ -233,6 +233,7 @@ int hsch(struct subchannel_id schid)
>  
>  	return ccode;
>  }
> +EXPORT_SYMBOL(hsch);
>  
>  static inline int __xsch(struct subchannel_id schid)
>  {
