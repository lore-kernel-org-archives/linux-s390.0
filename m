Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CA2FC01B;
	Mon,  3 Aug 2026 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773377; cv=none; b=JlkDkZAD6rKYPvwQgvgdggN23OChqF8NJCHuE7xpFyJIdNScbmH3jj24rZ6oj82ipnfnioEIA8Ln1Gcx4LIvYbEZzaFL/UHsQrcrsiiO/7QL14/pcjYy1qLBGzd3NPTYZJTUQpgrqS+h3c1Q7sCGyR/8mXj2U5+gKzK9E+Kg8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773377; c=relaxed/simple;
	bh=BR5LyePrpS9h8AybXICdDrj2cmb4iRINLPUasY9qlDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP6f0teEValHmW1qYFWD69PtYGnkmjo/TZMuNlhUYDPLNJY3VLZheTBd/QIuL0MkmsOAXZlErOC65rfVwWaDt1w1RAosYeGxctySOpmaRPKlSN9J9sX+WZi2r9H/z0qUgwllGey8IcvWRY0L5nR7js377Z564h28AFVcqENx2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c8l1AhYu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c8l1AhYu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHxeg2202477;
	Mon, 3 Aug 2026 16:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hbfUHvHy4rJgJYRqw
	Hxt4tDJx/XjWuiWcL78OHM6TI0=; b=c8l1AhYukvTyJEfXYv3dH+EaCourgm7OL
	LSY2RTziUp2htgx6hlD3Jr2jT95txtPChVdsWbpBHjPBkeQxms8TX43NExXrIEff
	PeCO7hl7jxWH4ehvhFs1h4VK92QFSU7Y+rZfgLOvNxziKAapPF4gSRBh+teTogs/
	T3RSXUvsgcX2533kAHllDzGG8n3JxsDJw3foDWWWURjLUWSXFBFNl9rBkB57qyaV
	xvfoeTeeMKVZ8LxbwllK+NkD1IXFA7sK6pQX0IH2F7/bzSuI3Ovn44lUIEATk3J9
	iuHlY1O3ciLBssQ+o0vOUHjfuIGdbmIHRamBF+up8Hm1STZAh6++Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhnpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuLdT025350;
	Mon, 3 Aug 2026 16:09:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jx5y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9Ppv32899492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 142772004E;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAD872004B;
	Mon,  3 Aug 2026 16:09:24 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:24 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 01/23] s390/vfio_ccw: Free all memory if cp_init() fails
Date: Mon,  3 Aug 2026 18:09:02 +0200
Message-ID: <20260803160924.236807-2-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXwA6f7UaLNs/+
 gGAfbS+e6gWNwbwWCahwacXnzgSGEK1WwhEacOcohCJQDTQ5LL/7Le4JpVQtWLhT1wtKoH239gi
 JQuk3RSNvShKuf3AeJoW39A/uk8saDs=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70bd3c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=WEmllObKAWPfCt-5-jUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX5LeYct5JM9l2
 jee9cC407Q1ssywpZKPob/7tHZJ7gWXgtQXbnZO1n1WZFPtOvZ7n5AnXTGIAUWXob3VDCr52QAd
 1VrhVN5GkRO3Ooafx3ocFGqsP+35e9XNXFqoe41Lae33FXEUaoZERAsYKi1EE7NrsvJ/h/1h69t
 skVuOHwZ2NENO+GjTRtnzgAgUJGdmj3Nun3xagt83u1ioMY32HHYdfSJqaWZdMp25LeW3HwH+bq
 Toi0PJosi5z8Ap5TLBx8zRpffTTGcy6bpNqNSgNeNxeYEhhRi2og1BzTey/gdRtilUyQ/E7EpjH
 waZK9A3iQkbC7HpG9zQl+KE4tt1CKN38bdGGis7WFYkmUB6qBOM0hGA5TofPA5kUHmxZDpxEZjd
 hDQzezn7YvtLQVh/1pJq38izEpqIJXVaufTWmb29gbnTwt4bwDwPeL7gmqxtLl1Dk9SRldJRcZ+
 Du0Hk3f8YhlNlxrtK5g==
X-Proofpoint-ORIG-GUID: XBJQiUDxfmlL9RYIu_CRtoi5IlTgRrwT
X-Proofpoint-GUID: XBJQiUDxfmlL9RYIu_CRtoi5IlTgRrwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

From: Eric Farman <farman@linux.ibm.com>

The routine cp_free() is called to unpin/free any memory once an I/O
is completed successfully, or if cp_prefetch() fails. But if cp_init()
fails, and cp->initialized is not enabled, the same routine cannot be
used to free all the memory.

An attempt to address this exists in ccwchain_handle_ccw(), where a
single call to ccwchain_free() is made for the currently-processed
CCW segment. But this will leak other segments (created as a result
of a Transfer in Channel) that had been allocated as part of the same
channel program.

Address this by performing the cleanup outside of the recursive
ccwchain_handle_ccw()/ccwchain_loop_tic() logic.

Fixes: 8b515be512a2 ("vfio-ccw: Fix memory leak and don't call cp_free in cp_init")
Cc: stable@vger.kernel.org
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 7561aa7d3e01..086d1b54bdb0 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -455,9 +455,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct channel_program *cp)
 	/* Loop for tics on this new chain. */
 	ret = ccwchain_loop_tic(chain, cp);
 
-	if (ret)
-		ccwchain_free(chain);
-
 	return ret;
 }
 
@@ -486,6 +483,23 @@ static int ccwchain_loop_tic(struct ccwchain *chain, struct channel_program *cp)
 	return 0;
 }
 
+static int ccwchain_build_ccws(dma32_t cda, struct channel_program *cp)
+{
+	struct ccwchain *chain, *temp;
+	int ret;
+
+	ret = ccwchain_handle_ccw(cda, cp);
+
+	if (ret) {
+		/* Cleanup if an error occurred */
+		list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
+			ccwchain_free(chain);
+		}
+	}
+
+	return ret;
+}
+
 static int ccwchain_fetch_tic(struct ccw1 *ccw,
 			      struct channel_program *cp)
 {
@@ -735,7 +749,7 @@ int cp_init(struct channel_program *cp, union orb *orb)
 	memcpy(&cp->orb, orb, sizeof(*orb));
 
 	/* Build a ccwchain for the first CCW segment */
-	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
+	ret = ccwchain_build_ccws(orb->cmd.cpa, cp);
 
 	if (!ret)
 		cp->initialized = true;
-- 
2.55.0

