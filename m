From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH 2/3] s390/cio: export hsch to modules
Date: Fri, 23 Nov 2018 13:30:48 +0100
Message-ID: <b7f5c715-c9fb-6a86-087f-d77ffe3e3367@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-3-cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20181122165432.4437-3-cohuck@redhat.com>
Content-Language: en-US
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
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 22/11/2018 17:54, Cornelia Huck wrote:
> The vfio-ccw code will need this, and it matches treatment of ssch
> and csch.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/ioasm.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/s390/cio/ioasm.c b/drivers/s390/cio/ioasm.c
> index 14d328338ce2..08eb10283b18 100644
> --- a/drivers/s390/cio/ioasm.c
> +++ b/drivers/s390/cio/ioasm.c
> @@ -233,6 +233,7 @@ int hsch(struct subchannel_id schid)
>  =20
>   	return ccode;
>   }
> +EXPORT_SYMBOL(hsch);
>  =20
>   static inline int __xsch(struct subchannel_id schid)
>   {
>=20

LGTM

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>



--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
