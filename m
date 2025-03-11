Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96919007D;
	Tue, 11 Mar 2025 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662557; cv=none; b=LmeSOab15Th1vv1V+wkTber3fwi/v9bHySwwWpKtk4EQRTQ3wiX+e5s5dOwX7eu21mYCTAz1Jj+Z/Ufyd9/yW9VbBBCy+YYFrpNoh7PYzXEBGsbRhr24u8apl/nYeUieZWbq++agePTPzhDywG6CDzzg/v+zynjK3v6TNyKMibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662557; c=relaxed/simple;
	bh=jpF7nF3TOxCImalYkQUW1dnGf4zCL9LpRq+kndEXvcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gF7/UA/jYPdg96lgd0MtGNC1teEGhu4sG1NGFCzihjvD6+6GLXSPMFoTPhlM2oett+pRQYC19eax0EZn8/S3wBKp6grjpHhzGqyBA1ZqG42g72xAnLtVn5peUxRQmsRTWEllBpYkrEO4kETN7X09a5ZnNPGUZYOftMqeYsQl6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JyXyZUid; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JyXyZUid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741662530;
	bh=URGpqlmXm/gPdMSb/V6zyT1v5OpXsXe6QBAf5N53/HA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JyXyZUidOCSAHMInO0RzYM0IlPF4UxV0khWQtd4pXk72F/g8tPiPgaZnA7PddxK7J
	 tDKhkWNuY6XWHQukPulWeP2jNLZPW80oAZBCVzJshFgNyGTNb+Ck7d/ru0EUs2pt+j
	 xlri6r71a2n4y0Dwp/kzPV1UDIO8qRfhaPTq/lw0=
X-QQ-mid: bizesmtpip4t1741662517tgfbwwo
X-QQ-Originating-IP: xvxneow0DBdsfSSOmoup5niZ/oqQn8R/tK9JRLfrlBE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 11:08:35 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11756624125615866169
From: WangYuli <wangyuli@uniontech.com>
To: hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com
Cc: wangyuli@uniontech.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	chenlinxuan@uniontech.com
Subject: [PATCH] s390/boot: Ignore vmlinux.map
Date: Tue, 11 Mar 2025 11:08:24 +0800
Message-ID: <F884C733016D6715+20250311030824.675683-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MDN2VRNR2P4wLboSgBu+93mRK0luZ7A0kqCAVkJOsXxyb71sZ6qO9jAC
	7TMCBLugyVtUyp9r9f3YVtMoB/TppNO9p5HcfKLaY3Xg5KUFS5ibNnnagV60PMpM1SEYGAe
	bVN1/FY/+PvyYY9invFLO7UbPE7BPfnzMYzC3//vwWLEZEuSN70QvyDsDmPYIKAP4ysEyGW
	dDWvoii9PIBDmkyilbvQaFiigeMy4dI/T0h4LGlhi6cC0T8mA/S1nXY7UEKHjVMBkzpb1Kk
	HBvEMOCp9b16kPhwelHVL2N8LEbd/lWM06M3WQUEtscoxsPyDLVM3Gyt/8sDY9yIawT7lWf
	tGhlQ8JNSVbtxTj6YXV10rIO95wMmKf0thDz9R6dqKdqUBbXyfGJqF46ILLOVz4Dmskh9xK
	ANyNjqlt0e/NWeqQdKmJsR9maXpY4Dn4gMlo/2dFUb5IvEpePIlBDi5vD9opxeSlwaCGNuB
	1Q/1wyKGOYDuWLJDlQAcMyNdz87+3+IddimVSNz954zFBR9gORMfJKmUHsH36UR71g25ulS
	aZ8I/varEb3Mexx1Lmzc/JtllFscJgbg3W7J72cVLBKSE9UCveRlV3MCB30SRQEwJrHFJ/A
	okhs7yCiw0F5RSKFv37kriulBEk77eeCpF6JiV5IeAKqGJX8RuIcswLMjZ4+SNYFGSZ8o44
	r0Ki2TswvDE4wvtrqQN6XKHh6v9/+I17UDRSQRg4j3FkwsWCHq2QxF12jza8aL4Tf2ob7Qv
	e4nwBGHLKaOl3Y0SIuX5sENnTdhoEpNET7MA8bWjgCRL4JRYIbfS9nGWbb0YEkxNesKt8nD
	fdf2GDctcepSGKTvYTPBaS7n+ruaspo4mCCgL4+kJ/D1sjohkXHjIDWTPpNb+se+7iZSq7N
	dbDwd1iTG5KUfHkVUKzgqSrJbazsZvzTozNtVXwCqaD3MtFzoKP/rSx9A1JisyDR0MvkuA/
	yGOvRNRteC3mwLLhwQvuuTMjRqaSDGuOCwOK6tF/k5mSXViU55pB6oTXvQk7yaiFrKjiesN
	RN85Ij27jfNG3QMOaYKbucaDA3aB4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Upon compiling an s390 kernel, a vmlinux.map file might be generated
in the current directory.

Append it to the .gitignore file so that Git does not track it.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/s390/boot/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/boot/.gitignore b/arch/s390/boot/.gitignore
index f5ef099e2fd3..af2a6a7bc028 100644
--- a/arch/s390/boot/.gitignore
+++ b/arch/s390/boot/.gitignore
@@ -5,4 +5,5 @@ relocs.S
 section_cmp.*
 vmlinux
 vmlinux.lds
+vmlinux.map
 vmlinux.syms
-- 
2.47.2

