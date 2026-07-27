Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D442B314;
	Mon, 27 Jul 2026 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170860; cv=none; b=mOIihne68nfbVkjdARhwt1stlrGbYoSTYTsvU954KthFGycdum5qwoxHo2DgiascEMRDEULeYqeIOvSDn31x2GoiJNknogos+bQgkl2zApiZ7JZv4Eyx/Fp4JF6zk+Yp1UN8Z8n/JCiXvibt3+7aBqU1moovRJqN31kLO5OomZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170860; c=relaxed/simple;
	bh=JbdAVIH/V+dcCTmGJRfR0JMfgH2g71CKT+aRIBUVV0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlC0Jzle/DWo6S4WUlu+XBb/FXJVejvexYt5bFtTyQwes/FgG3Qi3V3eRpyXd6FD3jrAjmHsz4c+sXC1y5MLs3MbPb40PWBk4SjNbRUfZwus5aLOwAxomdgODAdtUTiwH0MTkMMaUGEGuvNXFl2tQ7TsDIsOCsHCtRi+6b6FHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qWLHqwBt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qWLHqwBt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDncs32412257;
	Mon, 27 Jul 2026 16:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tLbSk8vuz1zJt2j8B
	Iy4h/R21/y96gtErWLfHBvXfKs=; b=qWLHqwBtqIuU5wXejwsIj6QfbQXLRuI8n
	p7Gv/62AixhfAhExRQQ+Yi6he+jjWmtcUJ0qwu5FI+9kSzJrLWbqAQva5vxhhk9j
	7X3T0I2vI2RrNgJyXurkRDnW5jgK9eDqZ+/a+0hufxP3q3dogX8wL9qTChKw1mo2
	gYiAjvcFyWAc/NJ6b50yvjzPwD9P9k4E3wpXQeyKn5xD5jKIijmt081aKJOrzyZs
	JTysdQ6jo1y62IEgazN1O6hv1d9W/8NV7KstQYSrYjeinLYrRKDQFcl5h43yuaPE
	CBv6N6cqqSFmG98KHQut0XKIq/MQowp0RKpLspkbOc4l93uBqyrPg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcrnr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:47:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RGfKBH023269;
	Mon, 27 Jul 2026 16:47:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjx66y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:47:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RGlMXA12190178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 16:47:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70ED220243;
	Mon, 27 Jul 2026 16:24:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14F5A20248;
	Mon, 27 Jul 2026 16:24:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 16:24:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] s390: Remove cond_resched() calls
Date: Mon, 27 Jul 2026 18:24:29 +0200
Message-ID: <20260727162430.1599396-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727162430.1599396-1-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Rka_o-CfgxRT0pZTerkRfzDUBqria0b
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfX0V+RXAhMl1g2
 lDcBt7ftvAOMo3bVUOB8I2T5Tx8nTKriDGZSye3NgTBsPthcN9p0gIDd7HxNw1GVS5RL6edFPC0
 xRxIzMbar0sEjXQyCE9ebz19xbvcBd4=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a678b9f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=rF5c3LEHrUaPZy42MJMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfXxko59IMtM/je
 I58wHckAF6qpkyjTJDRZ1vUMLvz+LjTlJl5JAREs6lah9iQlGC5ZIItj0zwtPRegN2EmZ2o4CYk
 RnKv/4LmRSNR+euEZChJVjph2xyGitGyMJ4kiaUR4nXtIz4bRYrr3EzXwgtFB7QxG8jnDDrqJML
 7PI10WVwiGbdaj5xe5D5koxuKVnTSw5CGbPcbtSdc65L9S4NeCZrJ5EiIdMDEXdE6MONlk6Xv+w
 BSTT7jcQrjMdg3X28YO9UmmooWzNwcL3SbJkgyvLIFmVZHDFnDtbTHB1O6DODuUYZ03qfeV/YJh
 Lq24VOZ1EtKaSQxDWgr3pqtzhH2LB6HfKyjCbWL2vcHNzHTQV9NgY1ic2rcnsAViP806riCtdCS
 w7W+dCamAhlEasSItw4syDNhBc9L8k16uJMEahqV0V/Yj7J3BtY6/n4YOUiP+QW0Y24hDALGNS6
 2hDLwhgdnvF5+eEmYKg==
X-Proofpoint-GUID: 6Rka_o-CfgxRT0pZTerkRfzDUBqria0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270151

Since [1] cond_resched() is a no-op on s390. Remove all calls.

[1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/perf_cpum_cf.c | 1 -
 arch/s390/mm/cmm.c              | 2 --
 arch/s390/mm/pageattr.c         | 5 -----
 arch/s390/mm/pgalloc.c          | 1 -
 arch/s390/pci/pci.c             | 4 +---
 5 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 2076ac22e2c4..5f2596be6c1e 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -1496,7 +1496,6 @@ static int cfset_all_copy(unsigned long arg, cpumask_t *mask)
 			goto out;
 		}
 		uptr += sizeof(struct s390_ctrset_cpudata) + cpuhw->used;
-		cond_resched();
 	}
 	cpus = cpumask_weight(mask);
 	if (put_user(cpus, &ctrset_read->no_cpus))
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index eb7ef63fab1e..d342b68ee9be 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -95,7 +95,6 @@ static long cmm_alloc_pages(long nr, long *counter,
 		(*counter)++;
 		spin_unlock(&cmm_lock);
 		nr--;
-		cond_resched();
 	}
 	return nr;
 }
@@ -134,7 +133,6 @@ static long cmm_free_pages(long nr, long *counter, struct cmm_page_array **list)
 		inc = __cmm_free_pages(inc, counter, list);
 		if (inc)
 			break;
-		cond_resched();
 	}
 	return nr + inc;
 }
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index e6f788696dd1..1e202e3d08e7 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -105,7 +105,6 @@ static int walk_pte_level(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		pgt_set((unsigned long *)ptep, pte_val(new), addr, CRDTE_DTT_PAGE);
 		ptep++;
 		addr += PAGE_SIZE;
-		cond_resched();
 	} while (addr < end);
 	return 0;
 }
@@ -194,7 +193,6 @@ static int walk_pmd_level(pud_t *pudp, unsigned long addr, unsigned long end,
 		}
 		pmdp++;
 		addr = next;
-		cond_resched();
 	} while (addr < end);
 	return rc;
 }
@@ -281,7 +279,6 @@ static int walk_pud_level(p4d_t *p4d, unsigned long addr, unsigned long end,
 		}
 		pudp++;
 		addr = next;
-		cond_resched();
 	} while (addr < end && !rc);
 	return rc;
 }
@@ -301,7 +298,6 @@ static int walk_p4d_level(pgd_t *pgd, unsigned long addr, unsigned long end,
 		rc = walk_pud_level(p4dp, addr, next, flags);
 		p4dp++;
 		addr = next;
-		cond_resched();
 	} while (addr < end && !rc);
 	return rc;
 }
@@ -323,7 +319,6 @@ static int change_page_attr(unsigned long addr, unsigned long end,
 		rc = walk_p4d_level(pgdp, addr, next, flags);
 		if (rc)
 			break;
-		cond_resched();
 	} while (pgdp++, addr = next, addr < end && !rc);
 	return rc;
 }
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 7ac44543e051..9610770fcf6d 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -268,7 +268,6 @@ static int base_segment_walk(unsigned long *origin, unsigned long addr,
 			return rc;
 		if (!alloc)
 			base_pgt_free(table);
-		cond_resched();
 	} while (ste++, addr = next, addr < end);
 	return 0;
 }
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 39bd2adfc240..2dec238f3f12 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -1173,10 +1173,8 @@ int zpci_scan_devices(void)
 		return rc;
 
 	zpci_add_devices(&scan_list);
-	zpci_bus_for_each(zbus) {
+	zpci_bus_for_each(zbus)
 		zpci_bus_scan_bus(zbus);
-		cond_resched();
-	}
 	return 0;
 }
 
-- 
2.53.0

