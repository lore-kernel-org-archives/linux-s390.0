Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80643E498;
	Tue, 28 Apr 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391827; cv=none; b=cw0nioGU45J+27XHpiCEsy/UxlQZwZef4BxxLL9L5EcPTbXL28DvXbs16gthSCnnPeGYEKvmtAzVqtfQJbHEUTG+A3YKac+wDmwKrt4+ldA/82xtPEE2DwSOZwyqNXYbTaL+FYYtdHOn+iVCL22fHTsDi7ribyw7WOD4F39+DIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391827; c=relaxed/simple;
	bh=FYWuKPWINc9YF2zgjOWZ0BZHLptFdr2uvy3LtVx3CgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kn8Z3fHm2jqz1Beb48MRQAh7eMYl/lw2ErV3r7U9XaFMNW5k38tLBwiN2IqpehRvaB8I275j66Gju6Q1jp1R/m9Wo38p2d09XJYjc9cSLxhPrEijuu2TCjkZMikxdnV+QZlYZikeyzjQ3F8Y+YFnHd4V6xm2hUAobBfb18HCn94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J1TrKeey; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J1TrKeey"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6Yfmn2886656;
	Tue, 28 Apr 2026 15:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HvFamDrzfqTBk2moS
	VyEtjHwHFd+La6MkhnKxWMpwDQ=; b=J1TrKeeyo4A1OEkjO4uO7K5fLF1IgLf5I
	kRzUiXQFH6wc5UJ+gD3B4UusSUqDeE/KFZm6LUXnqKHUc+t+OzL1MSjxUBdMrcUp
	vL6PgBi1shjWUkFZ+56JisAWAfoTQDQh0hS4HiMobjwj0tY2Li9/N/wSFLOJIDWY
	6GyPGVuIWyq4jNH3BNPhvU8/IjbOA0mTx2g5MkzbsHfEFnzUDbpntNgxKEz0pNKi
	raYI7Vm6A9krigFj94xFOBHt6si4Eh0SbnV1Q4ubAeN1dfm94Bs5SpoSMGxXIPXI
	Q/mE+zO65tn430Un/rc87DnrFyB8kjGKClDHCJURIjA8hSkmW/Cvg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r6c9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrncO001923;
	Tue, 28 Apr 2026 15:56:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5ga83v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuSqT33685844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67BBE2004B;
	Tue, 28 Apr 2026 15:56:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1453620043;
	Tue, 28 Apr 2026 15:56:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:28 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 14/28] MAINTAINERS: Add Steffen as reviewer for KVM/arm64
Date: Tue, 28 Apr 2026 17:56:06 +0200
Message-ID: <20260428155622.1361364-15-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ffho1cbiAFvSVCFF-HDv81lkFwuwOQdw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX9I8XxaqG1LuS
 F0HPj9XT5UECPqcQz339XDzNoLfqQMVVSjEkS7kkvcneK8iEiLkQGrsXQfpXhXeOR/RDOQ/oqM8
 gJZD5Af3M1UebecIwN5OdnPW2kHR90UU4l+k+ndz34h4TjIakUZyeXK690o3SMJ7B3iGBlyGs7/
 5H19M0Lxv2Lr0VGu1Z+S+9yo6GwMdaIEuMQTaCbYOhK69vxW7Jm/Ax2bJrYkwcpT5SqBEB/luSX
 6kvhYYuQAjwmi7/LjfEUadwv+rqsSV8cxRob48To+N7c6y0nnr1HhdHFxDUXOnQJVmAaiRuEMkt
 +dHbL7z098G8p38O56Kzy/39NcgA7qMVPxI0WLcDAlDG8agi0UtSdYHBPjEFMXUwCikqukT6pCa
 kD92BpyhPj1/JJKFIHgShaUDWMg3dS7BkDVFRQKpoYNlSIjEUSNTTHSUJyyzN6akNG/yN4XADft
 /BZK0mU3+BpBRYKQz+Q==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0d8b1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=i0EeH86SAAAA:8 a=JfrnYn6hAAAA:8 a=LyeO4m0CWtv-FIbIQ4UA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: ffho1cbiAFvSVCFF-HDv81lkFwuwOQdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

KVM/arm64 and KVM/s390 now share some code.Add me as a cross-reviewer
from the s390 team to arm64 to help to keep both architectures in sync.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9cb2b50d24b7..9cb4942c7d7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13994,6 +13994,7 @@ KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
 M:	Marc Zyngier <maz@kernel.org>
 M:	Oliver Upton <oupton@kernel.org>
 R:	Joey Gouly <joey.gouly@arm.com>
+R:	Steffen Eiden <seiden@linux.ibm.com>
 R:	Suzuki K Poulose <suzuki.poulose@arm.com>
 R:	Zenghui Yu <yuzenghui@huawei.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.51.0

