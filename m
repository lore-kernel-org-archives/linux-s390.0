Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F1029E0F7
	for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2026 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774408104; cv=pass; b=dF9BQwM4O90agObR7fEIICfGA5rRyHz1QU0XEpsO61G7z5ttXcaDlUF1msyHhFF0iGPgko4jGIDkJccFyGryoYYhmMDdPPkjP16/4JlvQz80HB5oJe8ZEDwpSF3Nx94ttyIij89jS7CiGZ1zfybm048XXYa/+AxSwMjYBjALKus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774408104; c=relaxed/simple;
	bh=hJdcGCQ3mHxI4qcvqZp/CCaqOJ76l13MZ1DRKNMUyZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQMI/qsl9Kl+4iQIr9yOoBswi5q2jmCZVWhFZVOTNmdGrWvxveciPbTarwSabYJbK3fl6er1IZGPDaPqyTN03u7foLnv3JRYXS4wido09tMRj98ontOgxxqm4zIZenRU9B9aY7NCwpV9GxmYVrSrdYHvbXbKJXWERb8Mt/0i9uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsG2jCun; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsG2jCun"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-67df51b26ddso1079240eaf.2
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2026 20:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774408102; cv=none;
        d=google.com; s=arc-20240605;
        b=AirzIhfJD3JAKFiMPcozZa84aQT9pAecMNskOC7rA9CzEd5pxQtBBo0IWCIsAeD57/
         oR2o9gIyDCHLPmeGkKhIjQwxhgtNGBsf4krNo1GmDm7ReDkzJR8IBxveaOOOLLF4+wTg
         o3L7H1t43eO13/oDS/PZLHmTPMjY2FhazmwKy9i/f6pWQaLs6sPiW0jvsGAwSRlaV1o6
         xdkMqpjYT2rK4f+3vKYFgsx2/asbnCS6w9QvolrvP0Cl/EPMd01xXgRkt+FAbzkMNYoa
         Kizrbl62e1qvV+eiIWNnxyE4U582ehg6dLmYT2/H7kGFe7yBjPRTIUWVA5UWFYyeclGt
         qAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L1agqMYRVyCUyftxunjR/Gctujg8X1gDCx6TflvnIV4=;
        fh=1P169TpeTq7Ocy1aEBPbxjRNLcbxr2lorUoC8//2f6M=;
        b=HaxEgnhaS0C6JwStTSM0WQCDmCWrlQ1gE1M4IHcxI/JrzxpwXtk+EZChrSvtWK8T95
         Jl/8/BU4hO6uR04YX8XtQmjS4NEikC+KNoBYCw6+ltNhKmQZeYeaHFr1DhvaSNFTSPaw
         i64zTDZwVu99osdvLLn9gyclfbGsWhV7xypmVJdmwYNHBowK+5YXzLk6kcIeNSjeOQP6
         PisWyx+ytu+tGL51V2nD4JV8l3a6if6d/UdFg2HBf+ho/9yvD8fcrgUPTMcOXUxX4gCT
         pCn4G8RNVGVdLvpV/K3sG0mI8BaCGck6WLCJNtG8BIUDeUy8XWnIQ4XdkR/w3ObuklQt
         lEHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774408102; x=1775012902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1agqMYRVyCUyftxunjR/Gctujg8X1gDCx6TflvnIV4=;
        b=QsG2jCunF6U9HFdPFtYk1Fvt12375/QhCCqZnpk7qBrUJDtwoPwbZG00Jxz3BLNAhH
         6yC6bntNmHyq7x7cP0+N6/uwrnu4b91f6kk14zUUgBqddni3wPt6K7GfK3VBO9vnm3J1
         z+WYSyue1n99gDpMq448CDF5siFzxJf5yHSUwcyJx6VhvxvHBUVIoZCA8J8lRlFVzyE+
         VVj1VO6NGN1ab9PiGjH0rUmDjcUZDFcwiB5b34LaaumYSy57XOpRmbzP5Qhozw3636yE
         ih5IVdoV+6OvYilULBnmHxgj0HuKO1k2K64kakQdkM8JMyQ6HNVTAAeXTM51wOpVMwzo
         g5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774408102; x=1775012902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L1agqMYRVyCUyftxunjR/Gctujg8X1gDCx6TflvnIV4=;
        b=N9M4m3lCpQp0N7h9+RI3C4cE93UB25h5wEAtuQltjZsX24BNQ2TlP2jXmwDagVNlTP
         ze4NJJtO2qH5QQbvxjAMtwUbrul0HjRv9hJBVKzNhZYfUSj2DwlCF7JJ2aHTayraahij
         n6V8+nUPcMlD35J3maNlsSpbKxdQVSYdRfeCv4mbcFCmiNag9lTYOdXJO+yoX6NM/rWJ
         s+hzua2WcvYWBgRzSzAGYlpa6s6jhtXlWIDZJ/QKYhaK8pBMYDRw9re+XJZDejVBks7U
         sbg/LnyEg7EY56RU/RJHA+0JoCRDbPXZaA9C2UAHxIg7HQuJS92vtsVndaY03i1+vIjC
         e65w==
X-Forwarded-Encrypted: i=1; AJvYcCUIS0eG3HmhYKLuzDcYU8r3cadVq3El+iIFDgw/9Ce2Bro4N8d2sODQyVSmpxX6hcAvhxCeVlynkbXF@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYBBoGQrsutJ6sW4sxY6hTfuvIOSAdaFiqhz44MzZ/oyhvsa1
	KvO+b3hYa2YZx6ptCtiAqjeFvBMWMxaqlri5jn1I5eQpD41ALI012Jo5+1+nMy9q52xpCiyn83X
	mUXIV9tS1Ce4i3IWsFKY0IX6/TABq8Cw=
X-Gm-Gg: ATEYQzwU+aLCI1XqYL0OnAYdjzFfF+fta+D5uyp65f3vr/u0yB1TmQiBeTSElTajiLu
	iUazTQIwLk6cqkJChz2pTqxcMApYSkpPx22zK+nCaIaivyxz0tj7QSW3ZD5tQH2Vc9BlbmDVtQC
	SPUXmFadvtJ5XUY4kdlLd9Dd7p6fQeQ12UMZwIhEVGT1bBi6Z/sJy9oLFsAT8OLO+t7iFvfGJpG
	9ONlDlLYAz85VVh8Ub6ajSxb9VixbDntwy4Y/294KSxMiv1cpJCwua2dU+jQCbS4VoBV+BjRvlt
	ycoP+YmQdVXIt/KEHYDgeJR1MmFPhePWutvzfqy/u5V2Jm4cnGPSFYjrOeMW++iUtLwFsGbEuK7
	2ALKNP+I=
X-Received: by 2002:a05:6820:1787:b0:67b:e203:6c8d with SMTP id
 006d021491bc7-67dff53efc8mr1216692eaf.52.1774408101668; Tue, 24 Mar 2026
 20:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-6-dakr@kernel.org>
In-Reply-To: <20260324005919.2408620-6-dakr@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 25 Mar 2026 11:08:11 +0800
X-Gm-Features: AQROBzD64p8E8k4KuR51RUiYotZVMtC9NAESBq-7RvJsmuQyKbQ4KJC_uWmm37s
Message-ID: <CALbr=La3gV5VmoXauF-fkmXveoJGtTvef1d1nrLtUZNHx2eF+w@mail.gmail.com>
Subject: Re: [PATCH 05/12] PCI: use generic driver_override infrastructure
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-spi@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-arm-kernel@lists.infradead.org, Wang Jiayue <akaieurus@gmail.com>, 
	Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:00=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> When a driver is probed through __driver_attach(), the bus' match()
> callback is called without the device lock held, thus accessing the
> driver_override field without a lock, which can cause a UAF.
>
> Fix this by using the driver-core driver_override infrastructure taking
> care of proper locking internally.
>
> Note that calling match() from __driver_attach() without the device lock
> held is intentional. [1]
>
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kern=
el.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220789
> Fixes: 782a985d7af2 ("PCI: Introduce new device binding path using pci_de=
v.driver_override")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Tested on QEMU PCI with multiple debug configs enabled. The original
PoCs run cleanly without triggering the issue.

Thanks Danilo.

Tested-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Gui-Dong Han <hanguidong02@gmail.com>

> ---
>  drivers/pci/pci-driver.c           | 11 +++++++----
>  drivers/pci/pci-sysfs.c            | 28 ----------------------------
>  drivers/pci/probe.c                |  1 -
>  drivers/vfio/pci/vfio_pci_core.c   |  5 ++---
>  drivers/xen/xen-pciback/pci_stub.c |  6 ++++--
>  include/linux/pci.h                |  6 ------
>  6 files changed, 13 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index dd9075403987..d10ece0889f0 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -138,9 +138,11 @@ static const struct pci_device_id *pci_match_device(=
struct pci_driver *drv,
>  {
>         struct pci_dynid *dynid;
>         const struct pci_device_id *found_id =3D NULL, *ids;
> +       int ret;
>
>         /* When driver_override is set, only bind to the matching driver =
*/
> -       if (dev->driver_override && strcmp(dev->driver_override, drv->nam=
e))
> +       ret =3D device_match_driver_override(&dev->dev, &drv->driver);
> +       if (ret =3D=3D 0)
>                 return NULL;
>
>         /* Look at the dynamic ids first, before the static ones */
> @@ -164,7 +166,7 @@ static const struct pci_device_id *pci_match_device(s=
truct pci_driver *drv,
>                  * matching.
>                  */
>                 if (found_id->override_only) {
> -                       if (dev->driver_override)
> +                       if (ret > 0)
>                                 return found_id;
>                 } else {
>                         return found_id;
> @@ -172,7 +174,7 @@ static const struct pci_device_id *pci_match_device(s=
truct pci_driver *drv,
>         }
>
>         /* driver_override will always match, send a dummy id */
> -       if (dev->driver_override)
> +       if (ret > 0)
>                 return &pci_device_id_any;
>         return NULL;
>  }
> @@ -452,7 +454,7 @@ static int __pci_device_probe(struct pci_driver *drv,=
 struct pci_dev *pci_dev)
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
>  {
>         return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprob=
e ||
> -               pdev->driver_override);
> +               device_has_driver_override(&pdev->dev));
>  }
>  #else
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
> @@ -1722,6 +1724,7 @@ static const struct cpumask *pci_device_irq_get_aff=
inity(struct device *dev,
>
>  const struct bus_type pci_bus_type =3D {
>         .name           =3D "pci",
> +       .driver_override =3D true,
>         .match          =3D pci_bus_match,
>         .uevent         =3D pci_uevent,
>         .probe          =3D pci_device_probe,
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 16eaaf749ba9..a9006cf4e9c8 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -615,33 +615,6 @@ static ssize_t devspec_show(struct device *dev,
>  static DEVICE_ATTR_RO(devspec);
>  #endif
>
> -static ssize_t driver_override_store(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    const char *buf, size_t count)
> -{
> -       struct pci_dev *pdev =3D to_pci_dev(dev);
> -       int ret;
> -
> -       ret =3D driver_set_override(dev, &pdev->driver_override, buf, cou=
nt);
> -       if (ret)
> -               return ret;
> -
> -       return count;
> -}
> -
> -static ssize_t driver_override_show(struct device *dev,
> -                                   struct device_attribute *attr, char *=
buf)
> -{
> -       struct pci_dev *pdev =3D to_pci_dev(dev);
> -       ssize_t len;
> -
> -       device_lock(dev);
> -       len =3D sysfs_emit(buf, "%s\n", pdev->driver_override);
> -       device_unlock(dev);
> -       return len;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
>  static struct attribute *pci_dev_attrs[] =3D {
>         &dev_attr_power_state.attr,
>         &dev_attr_resource.attr,
> @@ -669,7 +642,6 @@ static struct attribute *pci_dev_attrs[] =3D {
>  #ifdef CONFIG_OF
>         &dev_attr_devspec.attr,
>  #endif
> -       &dev_attr_driver_override.attr,
>         &dev_attr_ari_enabled.attr,
>         NULL,
>  };
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd79..b4707640e102 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2488,7 +2488,6 @@ static void pci_release_dev(struct device *dev)
>         pci_release_of_node(pci_dev);
>         pcibios_release_device(pci_dev);
>         pci_bus_put(pci_dev->bus);
> -       kfree(pci_dev->driver_override);
>         bitmap_free(pci_dev->dma_alias_mask);
>         dev_dbg(dev, "device released\n");
>         kfree(pci_dev);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index d43745fe4c84..460852f79f29 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1987,9 +1987,8 @@ static int vfio_pci_bus_notifier(struct notifier_bl=
ock *nb,
>             pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>                 pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_overri=
de\n",
>                          pci_name(pdev));
> -               pdev->driver_override =3D kasprintf(GFP_KERNEL, "%s",
> -                                                 vdev->vdev.ops->name);
> -               WARN_ON(!pdev->driver_override);
> +               WARN_ON(device_set_driver_override(&pdev->dev,
> +                                                  vdev->vdev.ops->name))=
;
>         } else if (action =3D=3D BUS_NOTIFY_BOUND_DRIVER &&
>                    pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>                 struct pci_driver *drv =3D pci_dev_driver(pdev);
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback=
/pci_stub.c
> index e4b27aecbf05..79a2b5dfd694 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -598,6 +598,8 @@ static int pcistub_seize(struct pci_dev *dev,
>         return err;
>  }
>
> +static struct pci_driver xen_pcibk_pci_driver;
> +
>  /* Called when 'bind'. This means we must _NOT_ call pci_reset_function =
or
>   * other functions that take the sysfs lock. */
>  static int pcistub_probe(struct pci_dev *dev, const struct pci_device_id=
 *id)
> @@ -609,8 +611,8 @@ static int pcistub_probe(struct pci_dev *dev, const s=
truct pci_device_id *id)
>
>         match =3D pcistub_match(dev);
>
> -       if ((dev->driver_override &&
> -            !strcmp(dev->driver_override, PCISTUB_DRIVER_NAME)) ||
> +       if (device_match_driver_override(&dev->dev,
> +                                        &xen_pcibk_pci_driver.driver) > =
0 ||
>             match) {
>
>                 if (dev->hdr_type !=3D PCI_HEADER_TYPE_NORMAL
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..57e9463e4347 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -575,12 +575,6 @@ struct pci_dev {
>         u8              supported_speeds; /* Supported Link Speeds Vector=
 */
>         phys_addr_t     rom;            /* Physical address if not from B=
AR */
>         size_t          romlen;         /* Length if not from BAR */
> -       /*
> -        * Driver name to force a match.  Do not set directly, because co=
re
> -        * frees it.  Use driver_set_override() to set or clear it.
> -        */
> -       const char      *driver_override;
> -
>         unsigned long   priv_flags;     /* Private flags for the PCI driv=
er */
>
>         /* These methods index pci_reset_fn_methods[] */
> --
> 2.53.0
>
