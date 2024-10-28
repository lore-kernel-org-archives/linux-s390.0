Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364AE15EFA1;
	Mon, 28 Oct 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104067; cv=none; b=RL+mlEgG22BR5xKo3QCSfGzfFeK2nUYPYMeRDlPxCItJmAl41ZPUlxmfocsLCcBNPpNI7Bt75teOV7x4JcvRVQU7h+NoA0I8G0mc+X/aEYOHxN3h3HGGAXLiHY8AH6XBIqd+J7m6ozK28MRMzffdDH0lerkza6IY+zAvuuSnoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104067; c=relaxed/simple;
	bh=oMyeKSc/hvZsieomvDx5H4S3CcmyYmg5I/lJe+0Cr1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9SXDpxEWSiBkFkXfsG1/iOc6t8OEbV9YzpIf6i2WDtS28KP+DiURZXFzC8yydOwF4HT0ko2E4v3MLHkRdBHkSlxxajttLPbO+WP6hhkqp63wC9pMHTt09MCFJ84NcOonGl8DniIWKF0L+Wqd0JtAzXhG3YBS/HOu2DPaiBqvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JIYsEq5t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JIYsEq5t"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49S51TcO025674;
	Mon, 28 Oct 2024 08:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ME8bfsDlHx6G0GZVJ
	1aIQr0+SfGElV8Qn9jipKUPWSI=; b=JIYsEq5tUaOHUO4JvSeW8IcvrmjL5VyC3
	yxUsA9rf4bWuejU266ETcPwA9/eaWqXEC9PWCx6HfOo6E3Y1gkE/20sHiQoTGhuE
	aea0sLu66MJCk/uOZh1NlVYKaAaqiJMWWq2srViNwxy+JBHi4Kf+WD5ZlbjWrcjB
	0ODgiRiq1O2ux1vloVMWBxLyNCp9bFg7d13OVBrAatDgTANXyF+YdhAw9UcgLwsd
	kPynRxoqQ+sQGiMfC2FPN0+mGVUf3geqeBjDLf23BGg6c871nBHgHPF0Ogl0Wrky
	K48g2bq6wt1wAS4DBv1pyILiWB06pYE30eQpOBxlb4PuSemofXUVA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j43fryye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 08:27:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49S4rPQZ024560;
	Mon, 28 Oct 2024 08:27:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyj53dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 08:27:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49S8Remj54460924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 08:27:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53ACB20043;
	Mon, 28 Oct 2024 08:27:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41A9320040;
	Mon, 28 Oct 2024 08:27:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Oct 2024 08:27:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id F13CDE03DE; Mon, 28 Oct 2024 09:27:39 +0100 (CET)
From: Sven Schnelle <svens@linux.ibm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        "Heiko Carstens" <hca@linux.ibm.com>
Subject: [PATCH 0/1] s390: enable HAVE_FTRACE_GRAPH_FUNC
Date: Mon, 28 Oct 2024 09:27:37 +0100
Message-ID: <20241028082738.3293096-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <172991731968.443985.4558065903004844780.stgit@devnote2>
References: 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W7pCJSdJzYU7zwWDBuSPZBkki6CzoBJf
X-Proofpoint-ORIG-GUID: W7pCJSdJzYU7zwWDBuSPZBkki6CzoBJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=530 clxscore=1011
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280068

Hi Masami,

this enables HAVE_FTRACE_GRAPH_FUNC for s390. It is based on your
ftrace/fprope-on-fgraph patchset. I talked to Heiko, and we agreed that it
would be best if you include this patch in your "fprobe: function_graph:
Multi-function graph and fprobe on fgraph" patchset.

Thanks,
Sven

Sven Schnelle (1):
  s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC

 arch/s390/Kconfig              |  1 +
 arch/s390/include/asm/ftrace.h |  5 ++++
 arch/s390/kernel/entry.h       |  1 -
 arch/s390/kernel/ftrace.c      | 48 ++++++++++------------------------
 arch/s390/kernel/mcount.S      | 11 --------
 5 files changed, 20 insertions(+), 46 deletions(-)

-- 
2.45.2

