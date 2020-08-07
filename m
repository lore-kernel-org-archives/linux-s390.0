Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 00/22] crypto: add check for xts input length equal to zero
Date: Fri,  7 Aug 2020 19:19:48 +0300
Message-Id: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>

From: Andrei Botila <andrei.botila@nxp.com>

This patch set is a follow-up on the previous RFC discussion which can be found
here: https://lore.kernel.org/r/4145904.A5P2xsN9yQ@tauon.chronox.de

This series converts all XTS implementations to return 0 when the input length
is equal to 0. This change is necessary in order to standardize the way
skcipher algorithms handle this corner case. This check is made for other
algorithms such as CBC, ARC4, CFB, OFB, SALSA20, CTR, ECB and PCBC, XTS being
the outlier here.

Although some drivers do not explicitly check for requests with zero input
length, their implementations might be able to deal with this case.
Since we don't have the HW to test which ones are able and which ones are not
we rely on the maintainers of these drivers to verify and comment if the changes
are necessary in their driver or not.

One important thing to keep in mind is that in some implementations we make
this check only for XTS algorithms although probably all skcipher algorithms
should return 0 in case of zero input length.

This fix has been tested only on ARMv8 CE, the rest of the patches have
been build tested *only*, and should be tested on actual hardware before
being merged.

Andrei Botila (22):
  crypto: arm/aes-ce - add check for xts input length equal to zero
  crypto: arm/aes-neonbs - add check for xts input length equal to zero
  crypto: arm64/aes - add check for xts input length equal to zero
  crypto: arm64/aes-neonbs - add check for xts input length equal to
    zero
  crypto: powerpc/aes-spe - add check for xts input length equal to zero
  crypto: s390/aes - add check for xts input length equal to zero
  crypto: s390/paes - add check for xts input length equal to zero
  crypto: x86/glue_helper - add check for xts input length equal to zero
  crypto: xts - add check for block length equal to zero
  crypto: atmel-aes - add check for xts input length equal to zero
  crypto: artpec6 - add check for xts input length equal to zero
  crypto: bcm - add check for xts input length equal to zero
  crypto: cavium/cpt - add check for xts input length equal to zero
  crypto: cavium/nitrox - add check for xts input length equal to zero
  crypto: ccp - add check for xts input length equal to zero
  crypto: ccree - add check for xts input length equal to zero
  crypto: chelsio - add check for xts input length equal to zero
  crypto: hisilicon/sec - add check for xts input length equal to zero
  crypto: inside-secure - add check for xts input length equal to zero
  crypto: octeontx - add check for xts input length equal to zero
  crypto: qce - add check for xts input length equal to zero
  crypto: vmx - add check for xts input length equal to zero

 arch/arm/crypto/aes-ce-glue.c                    |  6 ++++++
 arch/arm/crypto/aes-neonbs-glue.c                |  3 +++
 arch/arm64/crypto/aes-glue.c                     |  6 ++++++
 arch/arm64/crypto/aes-neonbs-glue.c              |  3 +++
 arch/powerpc/crypto/aes-spe-glue.c               |  6 ++++++
 arch/s390/crypto/aes_s390.c                      |  3 +++
 arch/s390/crypto/paes_s390.c                     |  3 +++
 arch/x86/crypto/glue_helper.c                    |  3 +++
 crypto/xts.c                                     |  6 ++++++
 drivers/crypto/atmel-aes.c                       |  4 ++++
 drivers/crypto/axis/artpec6_crypto.c             |  6 ++++++
 drivers/crypto/bcm/cipher.c                      |  3 +++
 drivers/crypto/cavium/cpt/cptvf_algs.c           |  4 ++++
 drivers/crypto/cavium/nitrox/nitrox_skcipher.c   |  6 ++++++
 drivers/crypto/ccp/ccp-crypto-aes-xts.c          |  3 +++
 drivers/crypto/ccree/cc_cipher.c                 | 11 ++++++-----
 drivers/crypto/chelsio/chcr_algo.c               |  4 ++++
 drivers/crypto/hisilicon/sec/sec_algs.c          |  4 ++++
 drivers/crypto/inside-secure/safexcel_cipher.c   |  6 ++++++
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c |  5 +++++
 drivers/crypto/qce/skcipher.c                    |  3 +++
 drivers/crypto/vmx/aes_xts.c                     |  3 +++
 22 files changed, 96 insertions(+), 5 deletions(-)

-- 
2.17.1
