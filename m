Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981743B6CE;
	Tue,  4 Aug 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832105; cv=none; b=JF9njeBCF+03WJWt1PUqBf/DUToRYpQo9IUgJx8PuHveB3XXZfdGZsPBNff+3ulcHaclb7B+F5OU7TtJ7fMt+RmeIH2Rw2VALJThujW+7sgmsKEcUFow4vOhdFnpRGsWuqHyxMzlsJkysSLr4YgcNqXHimeBCMcAKhgu8thAA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832105; c=relaxed/simple;
	bh=upXELchte961i1B5LCMRw3HKSrJ3ve0mw525dlsYJeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qiPj9Hffw9N7i1mHtN1ISqoVG2NNIhtkXL07ZutsaMoI4cqZ9ca9GmEJHJ5NfR8p6gW5Yytpj9rQCgt+fDj3srFv/MMo3Q5eLk+b64M/R5hRbnRBw9Z/+oAA8+doe3uR+dbJxtb30gsRYm36fsIYMytfs3u5/oqYpuL2JHrVZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mXntV2cH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mXntV2cH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748IAoK2641931;
	Tue, 4 Aug 2026 08:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gwxiBwgSXoZcJs8DyireIoJ0S6YjdPJ6t3DLJK8L7
	Uk=; b=mXntV2cHztcbWem8OUdAF7HlCR/HNQ3lYVGXemQDN6XVDjgBVf5828RdO
	ABGYs35EAyI7u6DHJk07vGyVhrJxdacyoG9B51hd2F9YBMj+EO8EBlO2wCignx17
	4DZjDa2ZRIx6gEkqUqIJA84XSLYmkIJUWyr5TxvklqqbsfL0cIhUI5vWWswGN7aQ
	OIQZTxLUkeqNrG54A3s5sibv9kWb/n+1RWpYnEEYUwEkxZYykdRDRowaswU3B3KX
	+SVVpbU3QFpENVYUNHi9OJyEkN2PTfQYsaFHXJbAXksTd+v/Y7uFei/cEt/gshCh
	7XjmVFbwbgHUrhWnvDl+dl6I+RP1w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqmv1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 08:28:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6748QQlA009928;
	Tue, 4 Aug 2026 08:28:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k14fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 08:28:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6748S0QX28836336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 08:28:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D947020043;
	Tue,  4 Aug 2026 08:28:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A613B20040;
	Tue,  4 Aug 2026 08:28:00 +0000 (GMT)
Received: from t83lp68.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 08:28:00 +0000 (GMT)
From: Hidayath Khan <hidayath@linux.ibm.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
        sidraya@linux.ibm.com, mjambigi@linux.ibm.com, andrew+netdev@lunn.ch
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, pasic@linux.ibm.com, hidayath@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net] net/smc: fix socket refcount leak in smc_switch_conns()
Date: Tue,  4 Aug 2026 10:28:00 +0200
Message-ID: <20260804082800.498672-1-hidayath@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: IjvAAhz18_gPhiZFpPeVhnM70ceXBTgk
X-Proofpoint-ORIG-GUID: WcIJt3RnmNTDjD3Yt3xlRNhNuZlKpNzf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA2NCBTYWx0ZWRfX/vSMt2VCdLXc
 zuGIisBx+qAaHxVmtTsktVrMlBhem9ti+WNg9UtBy9PoxKZPEson2sVDVJh4qXGaPLS7mas9oFg
 7KYsChkdQjx9gwGevwqXwWtMmwFWMH8=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a71a296 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=QgwSWOpKMeOadBk2rDcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA2NCBTYWx0ZWRfX7YXV+r1rNCdJ
 VAUsUOKPAGTpVqCgkZzQWwfO8euSxfhrKADdrn1Mx1f7pLht6BaJLAytP62AnRUPnLYay6P4Kks
 6AqyXNruPgrYn1uC3S0M80q3CoZ1kZZTVQ0DqHxaERPBplyBRk7Dbl5Vro/2IkgbQaul2oK/+0b
 RsyoFOHcpXU0tzTtnKNfgQFLZlpQ3Wa4Zv9jmVtU+lka+jRUzwpDvFSHCh+Cd0brwSwDlsFTQx1
 /r4sOlmeHiJLLGLcJ/wbBNnlFFxuvW4O27dZT0JBaaguEaeFjTfc/nEhwQ0x+XMVxyik/EravH2
 0MJeZLzDyTx9C35oDMNIWKahS+qghNA+qSrJeBYE5uX6w1WKsr+yoFlBwjZfxMI7op1PfT/r6p+
 /fI3bF1ihsemVBIpwkXFZfm5H6VD7rIPiId3egsQEAp1pMKq8/3Q+nsNIwAHvHp1Mig41JPhPhW
 gmWNrQgZJRAu1WYEjpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040064

smc_switch_conns() takes a reference on the SMC socket before dropping
lgr->conns_lock, so the connection stays alive while the CDC slot is
fetched:

        sock_hold(&smc->sk);
        read_unlock_bh(&lgr->conns_lock);
        /* pre-fetch buffer outside of send_lock, might sleep */
        rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
        if (rc)
                goto err_out;

The err_out label only drops the wr_tx link reference, so this early exit
returns without the matching sock_put().  The second error exit is not
affected because sock_put() has already run by then:

        rc = smc_switch_cursor(smc, pend, wr_buf);
        spin_unlock_bh(&conn->send_lock);
        sock_put(&smc->sk);
        if (rc)
                goto err_out;

A leaked sk_refcnt means the smc_sock is never destroyed.  Its send and
receive buffers stay allocated, and for a user socket the reference held
on the network namespace is never released, so the netns can no longer be
torn down.

smc_cdc_get_free_slot() fails when the target link goes down or when the
connection has been killed while the switch is in progress.  Both are
reachable during the link failover this function implements, so the leak
is triggered by the same hardware events that make smc_switch_conns() run
in the first place.

Drop the reference on the early error path.

Fixes: 95f7f3e7dc6b ("net/smc: improved fix wait on already cleared link")
Cc: stable@vger.kernel.org
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
---
 net/smc/smc_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index b4208cb186c5..c0027d2fe4e8 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1148,8 +1148,10 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 		read_unlock_bh(&lgr->conns_lock);
 		/* pre-fetch buffer outside of send_lock, might sleep */
 		rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
-		if (rc)
+		if (rc) {
+			sock_put(&smc->sk);
 			goto err_out;
+		}
 		/* avoid race with smcr_tx_sndbuf_nonempty() */
 		spin_lock_bh(&conn->send_lock);
 		smc_switch_link_and_count(conn, to_lnk);

base-commit: e18c8f801a5aa6c1d26af3b359234f11c13ef2c0
-- 
2.52.0

