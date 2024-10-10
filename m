Received: from smtpout45.security-mail.net (smtpout45.security-mail.net [85.31.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCE1C9B6F
	for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565286; cv=fail; b=UumePgz7UDm9mHIF47NeCAOy5TfrS+a08VFvy2nAPGDClxenZ+DYlLQOkEuhxV3e+kHnIClDY304pMxa0gjVWtF0Zkrjc22njTvNoBfWxc0MKj73+Qd5wB1PwHmLc+oi7Z6qr4Z/nlMoq+vCXMSsGyuXFSUu/2ie4ICj8wwmv70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565286; c=relaxed/simple;
	bh=z21wRl5za9XYTf7OXpzfucjs98ObOaWhHiBwMbURSug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gqplbpz18SC7kffKhh05NeBTl8+Uuyk8cFYLDJO8+j2gsDRNsd9/IqEX4D8/pTsSDgGhFAbmUinBwhLdHO7Hfui3eMgO4iy4Iz0v6C50pqKXvEPpmWpiU/IIjFi+KzpgU460GeClgZ009FXLsfnC3iMU7KDtGg3XqyOUp7Ucxxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=PFFW4Y8I; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=UBbKdG9z reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="PFFW4Y8I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="UBbKdG9z"
Received: from localhost (localhost [127.0.0.1])
	by fx301.security-mail.net (Postfix) with ESMTP id B3CA252547C
	for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2024 15:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728565276;
	bh=z21wRl5za9XYTf7OXpzfucjs98ObOaWhHiBwMbURSug=;
	h=From:To:Cc:Subject:Date;
	b=PFFW4Y8IL57gSJw7ahWsIoiYGGokiAZEFNpKpF+yOHyRlEjqiTdiGjm6fDuXMhgfh
	 n72ZBTudSAfWOrD8yESYvFoRHRxFAkJf+fxpNMT40JfiMj6erC6AuKxkmEPHHYSTkt
	 JpkxBXtSZro03Z0QTT4wquMzoB0k+zODjsVdQm2U=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id 65D21525478; Thu, 10 Oct 2024 15:01:16 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011025.outbound.protection.outlook.com
 [40.93.76.25]) by fx301.security-mail.net (Postfix) with ESMTPS id
 AE8E6524459; Thu, 10 Oct 2024 15:01:14 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR1P264MB2094.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 13:01:12 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8048.013; Thu, 10 Oct
 2024 13:01:12 +0000
X-Secumail-id: <5cd4.6707d01a.ac940.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MV5dfeWkloXbStgmdUD7WaLEmPiFdj+fwOo6hFZgGA/QEy3nhj7vWtIRT9HOlnWrFaPBrgeK2xTJl8v2LweIhYNx/8Kdkz+StgG8cIiHNLTYnRL91wTM0cHMDu8oU4OWRxQPamjOsa10cqhkrmZkYAPPIFsFDRIQ7fDBpf5UWYC5d++uEFUMCAEAYmG1A4qnSTIrUOUbvkA/VyHvX9n8PGg0Vet/dOs+HDAc2/nQhRzu/JzxJks7OH7kwhfHaqkxAw/DPv4mmut5WQeE6GqPVKZ70aMPYtJV6KDktxQKUzpITV8XUtnQblhY35eI7mGZkXRsyzJgvgLCNj12kFg9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO3SvpSBdArS5P8ZdqiDG609gC9axUVDWJFPo442cAk=;
 b=obi6j1Dyp2qVKxSUq17ficEaMXLBtGngjDqIWTkUWXLSDOD20rb0oOgf3UenP9ttcBMTx4eJggXVwGVvg7IXKmoXyB5JrjOrnjvPYxgYK3nviaGq7P2Swy1Mh8K+bk0YQ5pBZ2nUxCv2Ux8+BvXXFN0x8CAM0ClauKQjRM3yQpHITEkNZqBbT1Yj1P70Evco5yExTbUOC77so2mfsioqjAUApgjU24cUUwi6opH0aP9SpomyGf9B25DvVR9CEML+dUoZCF9bz+WrYMQWiMdLNYYzPVTvJlHd3jBnNvYS1MPADVJ3qUyybtOHz88a+5DAe7d7cGR9uVJYXgKEtzL9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO3SvpSBdArS5P8ZdqiDG609gC9axUVDWJFPo442cAk=;
 b=UBbKdG9zysK3nPxDsWfWEKBcNEBQMHfZw1aBdj+1TY8f+O0OO3HTCcv5iRR7Yk18S8KvV93xSKgdLKpVrLje44YBfmYmgA/LlMwM0Fjwc+W5Q2KaQkWxbNdCGSP50mBkJ6Gvav14E3rdv9lqzlrArTmVph1pt603Tr0NRZVcV3dF/Dbsqcf00r7SVvOY5IA5FiHQIKkoqILNIr3A1yJIx9mLG8hz/nyLCM+rDlFvFkNXyWf9JVIfabBZh8+0EhQEVb6bwEp6cgKm6tkR5twodgYYPI0QnDlge58+aoAct2oRAe7pcTpdebFUsRlKhVtPkjqhGPVSHG4H93ASDXuVew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Julian Vetter
 <jvetter@kalrayinc.com>
Subject: [PATCH 0/1] s390: Align prototypes of zpci IO memcpy functions
Date: Thu, 10 Oct 2024 15:00:59 +0200
Message-ID: <20241010130100.710005-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0021.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::9) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PR1P264MB2094:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd2f280-2dcf-482f-73ae-08dce92b9e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: xhoJNhMkzZuBmG1qDpJ4vbI2BEctaxGdqN1mM0MmZAWpO7M6uiBz2b2/IzI2jAF6JDediV4dH+vS0Vmo44i9eSFR7GAU52GbgvTKwJI9NeO+JwDS69WsdvvAUzW/5mq7cuRhgSFtOPS8CwIHYoIuEqKshZWW567PvhRt6DfVkCmSvHeXetvEVuRSJOUiqd9YbNe4MCZdqKPfXLz9zp6Z1CLCCM5Tgsvvfo52C3T6hxxdR7OgqI3gz7iku/70VEfyVtCEFibrsPm09oHc+OrwllXgqFInYmqTUdkwJjTEoECDrRaIPgEZd7S7DbWHw/0G9VNGS103H2JblunIDljl4JWc0joh5FicWCeVKcCrDrxJ1g2dlGq2RVoIsEj/Z36g00UOZG1jjKl0GnXXPQcJ8Fqp+K+LNFsvXhbk6JDBSR+pZTHW6EKmQZyZj+cRuQ7aH+D3gQLaw+n1gLZmbwPbOPuFDe/nNHkk5eiuzn/rAacp4b7saD6La5Goc7SefIZVMsZ7/mbM9Rvh1K5LWoBgl6GO4bdKg5q1EC5SSCeJ9GTXOLgPXJeH11c8OTDGcjqdQs2p+RtVfWKjkSAFuwM0xihL2EorZo/07aWctj1KNsUvkUHl+dIW/ARSJrii65WJNY/xF3jAncQgF26EJWgVi2H+eHIEpv/EqrZMAcl8PewC5UArSq/Z3Lk++OXnMGq8olVTlJURJs5yiuNq12vJI4vJjZR2ZG2wgf+RtwFRlIdPkzL5gVs6J75a62rku/POfc8umMvO1OHQHC9zgx01be4ZRfIWeFqpS+cOratqf2vwqQ0PL3hPo/h6NX1EA4TAQExkCGQsoFCi9YmYMFAdNbmc5PybTjFvtVSP6/FivAjjE+ONgZMY+H/vZsoCgJ2AeqACdhy3DHtY1zmxR6T7JQhrTn5sgxb4UDu6g/8suFlKLzofCjmtzQUp7Sfdd1+gt7O
 E0c8GulWYovd8anWdVTrqwHWBMCFwH1FCeLzh6RPmeI07KxCgJvgm1bUQ1QDNf+nuuZfQCbIbhdZRyQE1tOwA7pEdEj1QuXkpaUDOhwtPrGSG/YdFUeQ+e/Qq0r1oCRUG96r4R/gO9cRVFf+o7GXQ5TyURFk8TwI8CMUck+zD6d+/cUCve9dMoD+RUQIFICBSNYonXtd6GgO4hlOPmOwf2CMxo7lYvfRUFbiH9uzWGGsCk83b2daQnJbCtEIswix4Cd/Q+m32jhIboPUK+96DYmEo+xfxXZvjNXmC3pj4C6CYG9Te5CG6rQPlcGnh/Ei1px0CLTLSPdXMVEoV1/vMqs8Obpjj36ObG7735iiTMoHVGCpZy4m0TgfM69Ge5Rh3D08sa0wWvFm24896SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +HGHrkgttrBWKFtFvXF6n3aPouKzeI0Geaalm5prqhNFw76P1nnmfNGmRnko7CEZ7B0BTf6iC5j9b9VRvlq71guXKxOSksPdL3yktq5bSW6H/Uv65Q0sP6GRsXACmrXaFk5mtOLowmQO6kjhoK5KqvOarkiqrj9rl/NYVhvhQvYHFJzJc/yfTeVz+6Hrqwpv8pCTpLDH+Z/RauZyxQf3ANQW1ivSWjK4fC5OeP4N9IpOQ4IizzGAyj8FrPhs3X+sJ5UmpOW+57AKz0mrN6igqJUCR/+tAYyOdd/Dx6yfVBdJnp3YnVTIeQ8SKQ05zYiUKP5EPxDwq8gbeEK9oZ76TRMbbJWkRZlcrvURCdTIsD9FnIwhd9UiUCaFz/3Lsj9o605tlMJWeKFlaFZ+5yOhWvpQAXgqBr1RfSm/JOuab3Fs0j/M46cyFwMEmTSnDCHwEWm1NB2Oimw7ZYxd4E3PX0RQq4wVYsjKdck7h963FIEAtnA/ljfegBALDzqes0RxMdlT+yXRw+clUKSgM8wxvOM3PciyLuLjD7/07LOuusq6X2JZRIOhXIY84ChJY+OhiYwBwqz6y2WlgEcOTYodU4oPunMk8zT7U/gg80e7AZ/LAjMjGHGN61rUg6u6CWE04DkQhdPclHDBEQoVNfIFlISTZQka9HkWKzobpfuDqSZ+OJtnJgrVa5W4g8Fbbwm0roegwkUBuOg6+v+uUs1FWL0qFrkYTJDY7ltkBYuWSWmJsgAxs+i33ULpDU7iqzzPv163LH2EpeLFRzRQUTNps0YcqnC8zmf1W/+a5K4kSxOxiDjDt9RGHK6cWnANY5CGQXUxQNgDY431h1l3gUCy5io1CXJN8hkOb5VWEC3x1yWckBhK7XOQqvk/JUrDFHVQYnBiupzbZk+d4/Y2Va42oNGgFrUF0H04aMJ5eUmUl1hpJEYZ2qyNnnYuc6dgSE2p
 AOay4MtOOM1USxtDxtanq8nNQW6cmeQQo+vqaW0GMKiFU+bhUhUcGfwMQU7x1uVD+tAzdIo+mHY1jx0740TUa7T56CqYK2TSK8tAb1Ac/OQ/+1Qy2E9q0aE8cc6HxorC4CXX8KOpEjim6Oyw14t9vuBNsy0cyFJBY3Vr+2PaIqQ7vlYr07zinesFwh+HGhIoxkeqVjtKjtImh5dMBS9O+b8+/Z05/ccEPzhdd+sHWYpmevHq6hToNR7UZbABxKLbfM/wd5NTN5aGwYVqBOEOfeNnQFICAeCzUtYMdse3eDT0CP3HsnOfe24w/2OSkpdW4vXzbqEHpJgijHjWqLQLJE8T63VxI6K1O72eZo73W78rgTxu3/rM6FK0GhPINGBibeYmJ5ZUdW9WxBsaqLVg3yyaK8s8Y+57nALUk39VJnLBfmB28UtWsLBTPcUxcXjXyJ3SNNCFYLSpUDtlYfQn1KSL7Mjgv4ji5Z3QSfuQ2FGLU3rDxWpHXuAL87ytZBvlhRjfhanqkeeTJp+NaaTkkn8fIUy+krkcvc5XuSJWtAxloVAO7oQ0vQbpa0UKCZ1N/z8Mb7HuZ0bzGTcOvJkRqneLaHmDnOzLw/n/3yKA39D+Yb3re4IRnFI8EPr6NKrk
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd2f280-2dcf-482f-73ae-08dce92b9e35
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 13:01:12.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8P5SE1tmMj1/JqEMRx/fdPuQXtmw2KPjQdvP3HWM6/iO9KuzNQjpTpVZLUwssErzZeWEbsQ9cP651f/nT8D6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2094
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

As discussed with Niklas Schnelle, I have dropped all the unnecessary
code from the patch and have just aligned the prototypes with the
generic ones from asm-generic/io.h.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Julian Vetter (1):
  s390: Align prototypes of zpci IO memcpy functions

 arch/s390/include/asm/pci_io.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1





