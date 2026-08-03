Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75133F368;
	Mon,  3 Aug 2026 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773376; cv=none; b=XumPhjY7BKTJ1KgjTYLFl/GQ4PLug3lJJqSjOk1gO3Gd+0Q2TR2kru4HVXhEg8QJ/EQTuPUL+3zuE899mejiN+tcMpUiMwTd0yHPFHhs2if41OYkr90frmW0qRWW7H9rCwZGnOrMNUi3Idtl4hsc2AVGSmD4bGNo3QaM4Pc+5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773376; c=relaxed/simple;
	bh=bSFzXhlz0RE/UMKp9yh7JEmKsaYSVDRd4/JqFYxsCtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5aK+4+AoKz5ezUik2wdPYJ8L1YKdpiKYFDuc7BBwK9DpzWNDjXi4Fku54+Pc7DJUguKUansxAEZeB3SKZbjf0KG/teYo6P4AwHYJeIj/5T+NoLK7d1qw731XgEA4+o2eEuc876API9eZBl6K7YU/BZniDhtECtPg75c2R/nzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AWanxRSy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AWanxRSy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHqbF2341571;
	Mon, 3 Aug 2026 16:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=riEV+XvrcZ/rVq9hD
	CpQ5SUhk650+69XnPtmHQPzAlo=; b=AWanxRSyH2P9btSFY7MnKdWGBiXBVhs2Z
	UItSD+LVvIOBz2EU0RgSMGI/RDvYebGCFhvnUB6DksCo2d31wKpoBtuOaGBuB4DD
	7grb1krZTsL7x6vGz8MHMNDH8FNUmWefCn9rvNZSxHbfPN4+9bWVJ57nJLbgQEiP
	ITxo7f9rmia1I0WYGASut/hxjuR43YccaGWgYfbn9BRjVehoHFQwAPOuAcRRe3Bm
	7wJmvO2Ijn0gM5Yh+oCV3KzyFMZNSNclT6UzRq9HDtcruI0uKTO2ZAl1eJlo/uP0
	bA2FOf7bvoCifw2JJylE3+XOgL6ZRe87j2KHXC6iel66DUv9kr5eA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euhbf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuHE6026463;
	Mon, 3 Aug 2026 16:09:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qeatu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9PrI32899500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A98E20040;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71BCC2004B;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 05/23] s390/vfio_ccw: Calculate idal length based on idaw type
Date: Mon,  3 Aug 2026 18:09:06 +0200
Message-ID: <20260803160924.236807-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 99h_IXvwS2pvFmgCU2jm_yvujET1p_D2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXwVSTcJfJE6cq
 4z5IWrygyXyZg+7yHMogZBOYmb0YKsvLyVtuRit7GOjeEtvaHbTxvs2iKdwRJf81Il59rkJKFpL
 L4GO+qlXDOWQu9QGF6KJ4wdAuSFDMvE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX+PgO6/hcLiN6
 Aqk7n4FVEB4vweTdqDJ8KrSONzvvXkC5jz5E7SWpHtDkDU+GXHUf9+dFjksEGeWzyuuJy6TcEms
 wqBWdAOKifv7TseqcsZnu81OWJ++C3bweabdWfn/zbIC9x72cW0R1e9WJpepHkIz2e2TvEHfer0
 50WM2hREnunrv4+ATDIsZpQ4HG69hXFt5tuSO9SRuAsM+2wQDqNVqExzI1wFoPiL8OFjbJWlHbs
 hUDDyr/mMOnHhlNSTQdJpPVK2jwi2JtIewEpOVj00s8fKTJteGbIbQFwB6rYRpa1wDr5BvNiJr2
 VTSHssfh9NSPSfU9TpjYZnif1bFXp6ZcyODZ5oREmpWEL345tXnW++TIM+Otn3BrXFGM9TN7Zm3
 uCvqaKV7eEbS/UUxNl8afGDx73Y5Ee1LA01JbDeGQ7A4tByXQOYVKfm/VBslEs2lRZdn+V92jvm
 ld/S4k4sJwLh2eb1Pvg==
X-Proofpoint-GUID: 99h_IXvwS2pvFmgCU2jm_yvujET1p_D2
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70bd3c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EwhpepNkZwNmKqsVLwcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

From: Eric Farman <farman@linux.ibm.com>

Sashiko pointed out that get_guest_idal() unconditionally calculates
the length of the IDAL presuming everything is a Format-2 IDAW.

The output of vfio-ccw is always Format-2, but the input can be either
Format-1 (31-bit addresses) or Format-2 (64-bit addresses). As a result,
the size of the guest IDAL may be incorrect and should be trimmed down.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.org/
Fixes: 1b676fe3d9d3 ("vfio/ccw: handle a guest Format-1 IDAL")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 6275794751cb..5ef082b8289a 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -233,6 +233,7 @@ static void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
 }
 
 #define idal_is_2k(_cp) (!(_cp)->orb.cmd.c64 || (_cp)->orb.cmd.i2k)
+#define get_idaw_size(_cp) ((_cp)->orb.cmd.c64 ? sizeof(u64) : sizeof(u32))
 
 /*
  * Helpers to operate ccwchain.
@@ -524,7 +525,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program *cp, int
 	dma64_t *idaws;
 	dma32_t *idaws_f1;
 	u64 first_idaw;
-	int idal_len = idaw_nr * sizeof(*idaws);
+	int idal_len = idaw_nr * get_idaw_size(cp);
 	int idaw_size = idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask = ~(idaw_size - 1);
 	int i, ret;
@@ -593,7 +594,7 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 	struct vfio_device *vdev =
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	u64 iova;
-	int size = cp->orb.cmd.c64 ? sizeof(u64) : sizeof(u32);
+	int size = get_idaw_size(cp);
 	int ret;
 	int bytes = 1;
 
-- 
2.55.0

