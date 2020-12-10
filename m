Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36449 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390244AbgLJTuW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Dec 2020 14:50:22 -0500
Date: Thu, 10 Dec 2020 21:48:23 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [Intel-gfx] [patch 13/30] drm/i915/lpe_audio: Remove pointless
 irq_to_desc() usage
Message-ID: <X9J7h+myHaraeoKH@intel.com>
References: <20201210192536.118432146@linutronix.de>
 <20201210194043.862572239@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201210194043.862572239@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, netdev@vger.kernel.org, Will Deacon <will@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh@kernel.org>, linux-s390@vger.kernel.org, afzal mohammed <afzal.mohd.ma@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Jiang <dave.jiang@intel.com>, xen-devel@lists.xenproject.org, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-pci@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Wambui Karuga <wambui.karugax@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Juergen Gross <jgross@suse.com>, intel-gfx@lists.freedesktop.org, linux-gpio@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Airlie <airlied@linux.ie>, linux-parisc@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com, Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>

On Thu, Dec 10, 2020 at 08:25:49PM +0100, Thomas Gleixner wrote:
> Nothing uses the result and nothing should ever use it in driver code.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Wambui Karuga <wambui.karugax@gmail.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org

Reviewed-by: Ville Syrj=EF=BF=BDl=EF=BF=BD <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_lpe_audio.c |    4 ----
>  1 file changed, 4 deletions(-)
>=20
> --- a/drivers/gpu/drm/i915/display/intel_lpe_audio.c
> +++ b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
> @@ -297,13 +297,9 @@ int intel_lpe_audio_init(struct drm_i915
>   */
>  void intel_lpe_audio_teardown(struct drm_i915_private *dev_priv)
>  {
> -	struct irq_desc *desc;
> -
>  	if (!HAS_LPE_AUDIO(dev_priv))
>  		return;
> =20
> -	desc =3D irq_to_desc(dev_priv->lpe_audio.irq);
> -
>  	lpe_audio_platdev_destroy(dev_priv);
> =20
>  	irq_free_desc(dev_priv->lpe_audio.irq);
>=20
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

--=20
Ville Syrj=EF=BF=BDl=EF=BF=BD
Intel
