Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8043921F8;
	Thu,  2 Apr 2026 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116936; cv=none; b=RKhTUVboBUyH/AkQEY4+V72vMN5PIFgwMJKhjb1YOUX49vH8N2Q3eYhg/KhyULjmm9zzdiMo9xCzn1qjm24JUaRv1+l/f3/uLQaqF7kjLjVYBjki4JPw367GiMa/4R18wGp5oK4rsmzPSyX/O3pyvc2KzbYK+IOv+EyQX7i/ZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116936; c=relaxed/simple;
	bh=3SWOr++zHu2sma86h3i+0zECpGChe8e/TE683U5/lc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYa3CZ7i6CEhO9227HFmlkwWSt8bvKq0oSfVfjrAh6gv4OFHoJAFUtAUrS90Iozc/Hm17JEdMtKItD3OjJHMCeFyh7nS3yNcDBzsz/eFUQb9YSyvWQ71UznPhGaPbAC3V/FXcf7+sgwSfq2TDPOL4cMp1QJ9Eo9kDoUxsqV4sJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ol6WmRkf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ol6WmRkf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631NtEMi188586;
	Thu, 2 Apr 2026 08:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=O+rErf5K3HFtSst/DlS9ZFOS2Mt7FyitpbDR2DIFh
	To=; b=Ol6WmRkfRfWbQRAeWdq/MjseHbAQti95rkRx2AAUi7YyNthJKoLoDCASB
	u3TzxLSPcUw8Q0S7y7f0Ch+CLgg4XjGyrOJ2w6SEQIAkW7Y7IRt+Yb0lSBRouscf
	IixY+8WokTuyOj4Mujg6rTgXX+OYBhcPO6f5wKJA8sIFGlvcYJwPTlQnPVtBSgK/
	6nhV37i9V1SxU+FEhq9QRjoYW8nX2ZZAnK0ls4QMXQ0hwXspcrr52BZfcjtGeTmf
	xlz92HcK6orFQuZThGcJj3hJRv7bQiiqapxN86CYeMdnkFg8IA0k7bIkrFiZhH9t
	Rucqrd1oI1gRyGbrM2eA+q6YX8XFg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnuujg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 08:02:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6325Odrb021709;
	Thu, 2 Apr 2026 08:02:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sassce8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 08:02:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632827hE57409916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 08:02:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42C922004B;
	Thu,  2 Apr 2026 08:02:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1261A2004D;
	Thu,  2 Apr 2026 08:02:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 08:02:07 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
Subject: [PATCH v2 0/3] perf addr2line: Rework disable_add2line_warn
Date: Thu,  2 Apr 2026 10:01:56 +0200
Message-ID: <20260402080159.2028733-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zQhmomI1wa7h50SVHc19diFPRaCBSeMO
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69ce2284 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=1fk0JtzURXIa7KAGPxYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2OCBTYWx0ZWRfX6FgvYq8hLDDK
 vnvd8wLjeyOZOlDTwxtHVW3b6odSGQdeMNVuTsoT01oMZ0gdvZwrYy1opRODsZMvT8aNbFjMSKJ
 Bsw+lGmDXqO8ssEV/ICsyqdhBD6nQFshmEbLZPY2trP28dN3buEY539JlqAbyYxbA35Bw1jc+He
 5B73Sj7vjrjV3F/ym/NbzbEfK4YBZ/OkbZNZnJ/3KY1VKZKKG9bNXh3z9lnpwIk54iuOzmg4Tnx
 00G3wO+TOutNcQiYrQpZcZaJfMcDEfA35mX83JS57WX7xCS3DItBX+zW7/l40BkLueFbnPTPZ2o
 6mMsCT21diNntMTAM2MOPX19Npiurtr7BgqnC/TMqcdbBuaISdInybSmx8CIp9A8wGoL91s27IY
 4e+Lq/voiroC2+bfltv5A7yANpQ7pWRQHJ6BSbDJiB7y2554qTEIdX3dFYxRmKSFgbJpWfoTZb+
 HoLpFbpMbqcZuBPkkRQ==
X-Proofpoint-ORIG-GUID: XSkk0N7nccENO1sYSy2RuuJV7xuRS94I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020068

Introduce configurable addr2line_disable_warn entry in the .perfconfig
file. Clean up addr2line configuration.

V1 --> V2: Update perf-config documentation.

Patch 1:
   Rename disable_add2line_warn to addr2line_disable_warn (with 'r')
   and start name with prefix addr2line_ to make it consistent with
   other addr2line_xxx configuration parameters.
Patch 2:
   Enable symbol_conf::addr2line_disable_warn set via config file.
Patch 3:
   Remove global variable addr2line_timeout_ms and make it a member
   of struct::symbol_conf. Update perf-config documentation.

Thomas Richter (3):
  perf config: Rename symbol_conf::disable_add2line_warn
  perf config: Make symbol_conf::addr2line_disable_warn configurable
  perf addr2line: Remove global variable addr2line_timeout_ms

 tools/perf/Documentation/perf-config.txt |  6 ++++++
 tools/perf/builtin-diff.c                |  4 ++--
 tools/perf/util/addr2line.c              | 20 ++++++++++----------
 tools/perf/util/addr2line.h              |  2 --
 tools/perf/util/block-info.c             |  2 +-
 tools/perf/util/config.c                 |  6 ++++--
 tools/perf/util/libbfd.c                 |  2 +-
 tools/perf/util/symbol_conf.h            |  3 ++-
 8 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.53.0
