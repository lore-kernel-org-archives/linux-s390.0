Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1559C3DAAB1;
	Mon, 31 Aug 2026 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170266; cv=none; b=NdvGffhtOXBYtHXHqeQFzsGjl2wVMCJrtydlS4S8+WyLadsAn0p4MRH2Jjc3+CiBmqiTn6nuE55te4VDTO3y/JpqHbeIO04rq0C/+35k5PWjbWSyNfswILgc3ztkfV6M5nr9sYF7aF6j3D32HihLBjWDGDYzDU0HkYB3UVpQQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170266; c=relaxed/simple;
	bh=PYF3iNeENBdSaiAGyN6wQYwEL8sItA6lmOBg8rYNCMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UspLyr1TzBEif4QUKsb9cNR161EtEUxU3xO12OIASEPBrNxmi507B/OBlNse5KGWYxQ8Nt5QRhTUyofnGStl395oJNucJYBM5ccobglqxv7GHsuexTJZx1MQH+ov7LLdUpgCHaHhDtDuXJDIT5cXd1nGTjdon0wpUFKU3okScOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cwX0+avZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cwX0+avZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V825M61640122;
	Mon, 31 Aug 2026 09:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YgwZSW
	C2bLmMyDbaQo4SVNBWV5SCX4gDWVO4DIJgLiM=; b=cwX0+avZQTsCBcNHVhOKjI
	QUwJUqlG95ZFoPKTsdMcWgqnD0VJdWo9mSKI8wKWv+vLFiPjIBfh0Yc0Ef5BsH5R
	flt9WnXnXFoFWacNfRt16f0CU6AHyRyi4lqWeoHMN+gOB8Kmev75Ow40sNI+2jow
	FPCcTGUlL7f1cN66FBdym6V++xgvuRsqTBVbLZboI+FNqILjrYnvvgrZ87Mu2yu6
	1Jhp3hmUYdLRaa9K3RU5nuxuOvv0k00M3YJqBGFuq7k1Ulq5bWjvMssnvxcBaDl8
	l52amKeFcZGrYbgC27+dt78x/YSziJ0YdWFUqJ/qyYAyyLkfrAEmFhsxGBLUN0iA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx58grb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:57:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V9uHKp027297;
	Mon, 31 Aug 2026 09:57:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjw76g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:57:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V9vKhh45679056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 09:57:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B69920040;
	Mon, 31 Aug 2026 09:57:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32BA32004B;
	Mon, 31 Aug 2026 09:57:20 +0000 (GMT)
Received: from [192.168.2.169] (unknown [9.87.144.92])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 09:57:20 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 31 Aug 2026 11:57:15 +0200
Subject: [PATCH v6 1/3] panic: Introduce arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-arch_do_panic-v6-1-a1e170a9e7fd@linux.ibm.com>
References: <20260831-arch_do_panic-v6-0-a1e170a9e7fd@linux.ibm.com>
In-Reply-To: <20260831-arch_do_panic-v6-0-a1e170a9e7fd@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Bradley Morgan <include@grrlz.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a955005 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=jcFIXsoQAAAA:8
 a=VnNF1IyMAAAA:8 a=vDqFKWyYXM9dIk6-_9sA:9 a=QEXdDO2ut3YA:10
 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-GUID: QjRJ6TAcTuxZ-UHNclo6fpuh7orvpax0
X-Proofpoint-ORIG-GUID: QjRJ6TAcTuxZ-UHNclo6fpuh7orvpax0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfX7oVg+dWNpXOX
 yLqIYfz3U0SKMksN7pcw43w8N/TvLj1ucV9jng1zPBSb8VGXhbslUFzA6ydsz6pU6w0LHqz+dFa
 6X+Zx2CNWkuBbHkKPJDVRUFw13c1UJg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfXzTA52SrYF5Xj
 8tmatHWwz0N312NzCHGDKio2v90rXL+zCxh1fq+Ki3YQdIaWpylfMGTS9hUnICD0mNCEeo64Zhs
 uwcljRAViY24NuXtyiY7Mvo9auL3KCIUlR1iKBeiopl1wLfxSDLhEoCw8C7XBhxE6nncEL3lPWo
 LfE26qTavmddX4dp+7w69iWYSjCdAy/lS2zwtHw0Ip7I06RAZ5L7PmAP2tj/c5rgvOGKrpUwRFK
 gBYSAcxqTaKzWf5hIFzc2Cy/JRQj27bYpqzvPNuNRkWHChFG+UvscnCIEUBvEPqkPtxh/cVbC3O
 IWiVjO5nYtVD+sX6bqzkxwvhRt4VNqh3DDaT/j64UHUxdOQyBiFB3vrfIXiCCvcQ2O8byL0n1h3
 fJRyqirtzkCT1Saf3Max3alIOVZaYMnM8nY7hc2aykNwsVGWlOuh1Ei1ZQpbo3th+ucGYa7oOa3
 vvToMPBDbjKYOwhmRWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310082

Introduce a hook for architectures to put their specific panic handlers.
s390 and sparc already has ifdef preprocessor checks to execute
architecture specific code. Pave the way for vpanic() cleanup.

Reviewed-by: Bradley Morgan <include@grrlz.net>
Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 include/linux/panic.h | 2 ++
 kernel/panic.c        | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index f1dd417e54b2..98dd7dfd27de 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -110,4 +110,6 @@ extern void add_taint(unsigned flag, enum lockdep_ok);
 extern int test_taint(unsigned flag);
 extern unsigned long get_taint(void);
 
+void arch_do_panic(void);
+
 #endif	/* _LINUX_PANIC_H */
diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..726a97842232 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -567,6 +567,8 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		crash_smp_send_stop();
 }
 
+void __weak arch_do_panic(void) {}
+
 /**
  * vpanic - halt the system
  * @fmt: The text string to print
@@ -756,6 +758,7 @@ void vpanic(const char *fmt, va_list args)
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
+	arch_do_panic();
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
 

-- 
2.55.0

