Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57944 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726640AbfKGP2p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Nov 2019 10:28:45 -0500
Date: Thu, 7 Nov 2019 16:28:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 03/37] s390/protvirt: add ultravisor initialization
Message-ID: <20191107162831.489e0591.cohuck@redhat.com>
In-Reply-To: <20191024114059.102802-4-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-4-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 24 Oct 2019 07:40:25 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> From: Vasily Gorbik <gor@linux.ibm.com>
>=20
> Before being able to host protected virtual machines, donate some of
> the memory to the ultravisor. Besides that the ultravisor might impose
> addressing limitations for memory used to back protected VM storage. Trea=
t
> that limit as protected virtualization host's virtual memory limit.
>=20
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/s390/include/asm/uv.h | 16 ++++++++++++
>  arch/s390/kernel/setup.c   |  3 +++
>  arch/s390/kernel/uv.c      | 53 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)

(...)

> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 35ce89695509..f7778493e829 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -45,4 +45,57 @@ static int __init prot_virt_setup(char *val)
>  =09return rc;
>  }
>  early_param("prot_virt", prot_virt_setup);
> +
> +static int __init uv_init(unsigned long stor_base, unsigned long stor_le=
n)
> +{
> +=09struct uv_cb_init uvcb =3D {
> +=09=09.header.cmd =3D UVC_CMD_INIT_UV,
> +=09=09.header.len =3D sizeof(uvcb),
> +=09=09.stor_origin =3D stor_base,
> +=09=09.stor_len =3D stor_len,
> +=09};
> +=09int cc;
> +
> +=09cc =3D uv_call(0, (uint64_t)&uvcb);
> +=09if (cc || uvcb.header.rc !=3D UVC_RC_EXECUTED) {
> +=09=09pr_err("Ultravisor init failed with cc: %d rc: 0x%hx\n", cc,
> +=09=09       uvcb.header.rc);
> +=09=09return -1;

Is there any reasonable case where that call might fail if we have the
facility installed? Bad stor_base, maybe?

> +=09}
> +=09return 0;
> +}
> +
> +void __init setup_uv(void)
> +{
> +=09unsigned long uv_stor_base;
> +
> +=09if (!prot_virt_host)
> +=09=09return;
> +
> +=09uv_stor_base =3D (unsigned long)memblock_alloc_try_nid(
> +=09=09uv_info.uv_base_stor_len, SZ_1M, SZ_2G,
> +=09=09MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
> +=09if (!uv_stor_base) {
> +=09=09pr_info("Failed to reserve %lu bytes for ultravisor base storage\n=
",
> +=09=09=09uv_info.uv_base_stor_len);
> +=09=09goto fail;
> +=09}
> +
> +=09if (uv_init(uv_stor_base, uv_info.uv_base_stor_len)) {
> +=09=09memblock_free(uv_stor_base, uv_info.uv_base_stor_len);
> +=09=09goto fail;
> +=09}
> +
> +=09pr_info("Reserving %luMB as ultravisor base storage\n",
> +=09=09uv_info.uv_base_stor_len >> 20);
> +=09return;
> +fail:
> +=09prot_virt_host =3D 0;

So, what happens if the user requested protected virtualization and any
of the above failed? We turn off host support, so any attempt to start
a protected virtualization guest on that host will fail (hopefully with
a meaningful error), I guess.

Is there any use case where we'd want to make failure to set this up
fatal?

> +}
> +
> +void adjust_to_uv_max(unsigned long *vmax)
> +{
> +=09if (prot_virt_host && *vmax > uv_info.max_sec_stor_addr)
> +=09=09*vmax =3D uv_info.max_sec_stor_addr;
> +}
>  #endif
