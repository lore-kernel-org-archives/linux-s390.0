Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48EA2E8B67;
	Thu, 20 Aug 2026 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208272; cv=none; b=qS0hsWh+ug5IRGVQiVVErQWAyVyJv3YWN3cUmFLMIKESkret/DVETVVt962woz5ZwHzairQgP5Sibvpf1ixEOs3xH/NuvbAVUaQBePe/1GrXOH8Iioxk2FecTgPdSboYJXAHPO5LWm0Fv73gambyB6WVksIDIT2fAesMipDSnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208272; c=relaxed/simple;
	bh=wF+7DgBiI9q6YOq9CWXI2c06QOKp/FPYWuOWvS/ZtPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmZIebncBBmM6rGOup7NDHMtcruzH0g36p09OMGLqeXTCVVgwdQNlwHMTVDTDPZB9se0O7+MWoFovlOXrs//GquejvFTT7QkFck0asbNCiO7jpduH80IfvDTSPTwBYluSlpJ3j4omzAUQjJrlch1UQrjtnIXvms7pHWRVg4ZHcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=E9m14nEs; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="E9m14nEs"
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
	by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id B6A7980808;
	Thu, 20 Aug 2026 09:44:17 +0300 (MSK)
Received: from i111667286.ld.yandex.ru (unknown [2a02:6bf:8080:147::1:36])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA id DiQCqe1ZM0U0-rE0e5Isq;
	Thu, 20 Aug 2026 09:44:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1787208257;
	bh=JGhw+W7M5vFOmJXMLZKSh+VpW2YjzZ7dFS9Lnz4kx5g=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=E9m14nEsWVHNh2U+5P5sVmwb7I3/d5421cyRZrRpGsDOSp+ux/VwSkB+DGs62p5Mj
	 s7IqM9o24/3ozkmy6BcK5BZi8sbdkE5bwxjLggvJppGbCVb6yKGXuTBmOxKXoRmBWm
	 twfVl5V3/trbQW/qtVfoCnXtP7RWmo/z2w4lUtBw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Troshin <drtrosh@yandex-team.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Troshin <drtrosh@yandex-team.ru>,
	Sasha Levin <sashal@kernel.org>,
	Karsten Graul <kgraul@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot
Date: Thu, 20 Aug 2026 09:44:15 +0300
Message-ID: <20260820064415.2061-1-drtrosh@yandex-team.ru>
X-Mailer: git-send-email 2.51.0.windows.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit 277740023def559a4a2ddc3e8e784ee37a0f16a9 ]

On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
populates V2 entries starting at index 1, so when no V1 device is
selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] ==
NULL and ism_chid[0] == 0.

smc_v2_determine_accepted_chid() then matches the peer's CHID against
the array starting from index 0 using the CHID alone. A malicious
peer replying to a SMC-Dv2-only proposal with d1.chid == 0 matches
the empty slot, ini->ism_selected becomes 0, and the subsequent
ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
offsetof(struct smcd_dev, lgr_lock) == 0x68:

  BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
  Write of size 4 at addr 0000000000000068 by task exploit/144
  Call Trace:
   _raw_spin_lock_bh
   smc_conn_create (net/smc/smc_core.c:1997)
   __smc_connect (net/smc/af_smc.c:1447)
   smc_connect (net/smc/af_smc.c:1720)
   __sys_connect
   __x64_sys_connect
   do_syscall_64

Require ism_dev[i] to be non-NULL before accepting a CHID match.

Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Link: https://patch.msgid.link/20260511062138.2839584-1-xmei5@asu.edu
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Andrey Troshin <drtrosh@yandex-team.ru>
---
Backport fix for CVE-2026-64048
Link: https://nvd.nist.gov/vuln/detail/CVE-2026-64048
---
 net/smc/af_smc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8e1e38bc0df4..e9dabe758a31 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -863,7 +863,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm_v2 *aclc,
 	int i;
 
 	for (i = 0; i < ini->ism_offered_cnt + 1; i++) {
-		if (ini->ism_chid[i] == ntohs(aclc->chid)) {
+		if (ini->ism_dev[i] &&
+			ini->ism_chid[i] == ntohs(aclc->chid)) {
 			ini->ism_selected = i;
 			return 0;
 		}
-- 
2.34.1

