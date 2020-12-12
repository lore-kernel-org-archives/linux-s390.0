Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:38 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] drm/i915/lpe_audio: Remove pointless irq_to_desc() usage
In-Reply-To: <20201210194043.862572239@linutronix.de>
References: <20201210194043.862572239@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791878.3364.1801400207641504053.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, ville.syrjala@linux.intel.com, Jani Nikula <jani.nikula@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     766ba1f937be5ec418bd759e40fccc0c8c42e271
Gitweb:        https://git.kernel.org/tip/766ba1f937be5ec418bd759e40fccc0c8c4=
2e271
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:04 +01:00

drm/i915/lpe_audio: Remove pointless irq_to_desc() usage

Nothing uses the result and nothing should ever use it in driver code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://lore.kernel.org/r/20201210194043.862572239@linutronix.de

---
 drivers/gpu/drm/i915/display/intel_lpe_audio.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lpe_audio.c b/drivers/gpu/drm=
/i915/display/intel_lpe_audio.c
index ad5cc13..1c939f9 100644
--- a/drivers/gpu/drm/i915/display/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
@@ -297,13 +297,9 @@ int intel_lpe_audio_init(struct drm_i915_private *dev_pr=
iv)
  */
 void intel_lpe_audio_teardown(struct drm_i915_private *dev_priv)
 {
-	struct irq_desc *desc;
-
 	if (!HAS_LPE_AUDIO(dev_priv))
 		return;
=20
-	desc =3D irq_to_desc(dev_priv->lpe_audio.irq);
-
 	lpe_audio_platdev_destroy(dev_priv);
=20
 	irq_free_desc(dev_priv->lpe_audio.irq);
