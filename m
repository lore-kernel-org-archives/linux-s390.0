Received: from smtpout45.security-mail.net (smtpout45.security-mail.net [85.31.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F11C9DFB
	for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2024 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565294; cv=fail; b=Njibkbgtn0sS9RhLobhIMp2VMagXKXYi/yTIHorwlPXT9G3GhdAgY1k4vfwtJl245onum1c263xwKJm0jxC9/lEM/jMU1PEaEarKgu8b9xT50EaBUDEQrxX1z/9WCprgqQobWx5g1ODQI1TloL59736uxnX5c3IgCV/TbeGeRS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565294; c=relaxed/simple;
	bh=ayafPFNYnFt1/5rF26GroyebNfd2lCs9ljrxy41lvgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JF0frPLuKK+hvUyYf1awIAnebpxQ9l0DAL9EFdFKwE7zNuI2JzVbHh0zpeOZ9Y2kzw8qcbeyx2ApWaZcnjpZG/McWANYdZ45FU+5w+DtHPk1PAzgOTviUitu/kRiSbt2U7FjiQyAGe4mfIabbxuEZYz3cSjH3C9DifHp3MuMftU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=i5Pjf8GM; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=bZrnc1qt reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="i5Pjf8GM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="bZrnc1qt"
Received: from localhost (localhost [127.0.0.1])
	by fx301.security-mail.net (Postfix) with ESMTP id AC1E75254D6
	for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2024 15:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728565277;
	bh=ayafPFNYnFt1/5rF26GroyebNfd2lCs9ljrxy41lvgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i5Pjf8GMtvBWH9IkQ4OAWAB2hzemyF+/pl3/xP714d6BxH61hPLFtkvEIDcQEWB1s
	 NBdLSXamszCb6t/3rdhQDgYHNP7A6mLfUkjrEB0nxc2sRhPv/85BDP8Yl/JMxWaCEZ
	 02hV5PvEggG+y/pRp+fyJ6JJ7XXO2AdQzO4Jtr9U=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id 7835A5252FB; Thu, 10 Oct 2024 15:01:17 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011025.outbound.protection.outlook.com
 [40.93.76.25]) by fx301.security-mail.net (Postfix) with ESMTPS id
 E016D524F4C; Thu, 10 Oct 2024 15:01:15 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR1P264MB2094.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 13:01:13 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8048.013; Thu, 10 Oct
 2024 13:01:13 +0000
X-Secumail-id: <5cd4.6707d01b.de445.1>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvfHvfb04gr08YGXhffEVdakfwxQ5Wo3YptUJkQhW1czwNBVq9IGsyROSF1duK4+zctn4btatkttNXoKl1hDSTYMILNkKmiHsWW0XuFUbecnFTrQoSYo3L0vjZ/2SslF7Yv1in6UCIioin+qaMegJ0rdqvyW6fwAzwG4LWHU8ZLN5SjIG7C03UmEzGzRcawY6E5TOub+O9Vev78PAVclbdqWzC3WspunLG1jO8op1hIXjK+jr6v+x9AchjsEpNwgt1jn7mFWN1guo+QvYapwua7OwStZI6/hoY3jlFLR7+346u8m9aiGlCU3hi+swIJCryvgi0VIp6z36SvpW4IAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+3fEC7SOUwUx/qOI833uJbDNYBhrlNz/zimP+DNebU=;
 b=mIe67ISO2cJAKHo8BxzxVWQsIIEAHx27GLwaVExvpFLZPk9PxdlzRg7M3Il4xQ6FcILMSCDD33vxycaC8aontuq/Bdniyvi6n/WWKO3Jyb+y84CZPQ6Wm+OAJsWaNcGNxEvR/N4Q+E2NXE2lIU5o44mqM4xDiPSNatUxIidlh/DGiHVNR+KdBtX8k8XCWJA0Xbe65EU3Dx2B9fQSJ94XvPNHhhIHSfCz4pzuG4+hDi83lIrhR/0OnSXLc813UjxYZnqxTxTYkJEbcjeYATLmf2UTeBvz9h6yYtJFfjKtdjAA03/ErxybC/efgaKhdwFgZxLxRrgfVf0w8DoKAlRWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+3fEC7SOUwUx/qOI833uJbDNYBhrlNz/zimP+DNebU=;
 b=bZrnc1qttZdc4WSnbEZ7W4MnXfV8j9pf860jPG60nWJ2xtX+4BQnUUPrXSYrJLMXWatuqvxBjg3yJ2i+9GYJA2sR8XO4DDDoJ1M0oqvk/RAHTfJbDSkfuwZj6ui0Rz/wss1FEwh3vB6dZXume44VZEfexiuIMhiqjriS73yVNx6okb1mjRVYotaMc2rE+lgSNc0nvM2QCReWjJHY1pFPgyPs8Zg3J7E9ulV5Tiv0Wxxrmi1kyBx8G91+lDTjYaMZnlk/dSXyCBphkbjvnnapCYtfms1mwJY5chgw5yhjgGNhfoMnd5nd2zXX+fAYEk4Ke08VuV4spCH8n879gOnCow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Julian Vetter
 <jvetter@kalrayinc.com>
Subject: [PATCH 1/1] s390: Align prototypes of zpci IO memcpy functions
Date: Thu, 10 Oct 2024 15:01:00 +0200
Message-ID: <20241010130100.710005-2-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010130100.710005-1-jvetter@kalrayinc.com>
References: <20241010130100.710005-1-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2bbfb1a-39dd-4402-b27b-08dce92b9e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: VPniEUFeDh7W1WrWGFAveGFHpfC8SQ0+bzwXAZfUC1l1BfapwZ/dnd5/oaIixDxibRqVY6q/qWOcXXTcuYqBrPbe7ui8ts90GEPxvtoJPZ5f6KF8pV8ZA/mhTVVZHi9mlDZRUzEpUt7IqHrMoRTmu4MiEVrPUAARy1i04kfEtn4f+/seZl7o+Z6YQuERILG+AcOAT4t55OowoIaMcSZXojUj2g1lpnnl3pURqKrgoHGJnb6iLfnPPaGBr6oXdEa9jmJWCkx8/YZRIyuJ0VNPqw344UYH2wm1LJBQDmlYqvQRcJSRI6HvKXd+ExBI21fQ6ePTWMLOpwmS2oqSwHQqXjDADaN0RUtJBpSnSmfOfVQYuSWExmqowPMD+HC9Hn07H5eElN001cTn5WGOuFS9GwN+/2MvzLImkKhzoXNG/htm8TN6AbURssN6aPGUY0DcXHn3ybGpPO4nfkiXz5+ps8FrsXxNTVDoO2CcYmGwz6SkVzBLW2J5DytlmAIzThho1zp61dZxz0IuvDfYONOnnmH205Yk9DT6iqJk1P9ROSKsngVn102lReci6Hys3TSPCceg0S/K3MG5s3n5ZPmBfmLCBvLjOfB5/4JKN7V7V/Ntj106RLSMtAsfsDMAddVH9vivGKu+vZ2d6Zbp0xg6LSmkckuvxaiOkFEuL9abclnaL/s2rexd6/dSSYKBgdq6tKHZ7LeD/Tc6/t+/knJs0tzK8ZCwol/lHKqYyCR+Fl2fnxesGtIbn0lLsHQ5lspc4DRMr2/qEPuTY0ML057fyeYA6AbF0bxaDHBG0R2cBTzS4D3BJzbXhtMFc6EdSe5QdHDouHeVo8oThRZSEhFrQrbnIgktebyjx0RiF9TOiV48LZXGfowNoe4X71P5al/VkjwmuNNTKDRRQgkM/pQY93Deuz83MLbU+EVD2ZBPMbUhzam1jcgnrB2r6rlj3pEO4VN
 8ZpDvYrmfXu2OvDc7ReD8+1vEGliDRRVmrqOPwmUZEUkUwQ2d1QkdoL3gLSoYNbPfXkoKaGR/O0NhPUli+0YWmwIrMpkBMsO7ghmd/ux8eh1+rU7b4ceEOJT1HmL3+Nv7Ah7A6Vp56UJ9sfy+tjhkasjZuyke5Y5vIU7VL3UlT7MCYmTl14A1qGRtf3l/NyORx9OMDM1KmgkJMQeXFEIA52dY2oA9JY7u9z+i0CsYXu1j8WCANRfkebSXJmV2eC5bodFy+/glG/g8elHvuEyBj3HR2Qqs9kLZ1OgUq+PKx9r0Gx1wIRHHVJOyUdlxxQw8vl7fwNI9mg0YsyJIsqKKrr1qFhcUvPj0OPWf6U7nKmWS+4/K9+Qon4F29IltPAIrNvTc0JQb1lcCGvRPbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PbMLZK8umpwGd1BQMEEz2lIiAA9CoFUfl1MTDb416IsnlrpVdROIlIlMOJZK7jGKG2ZwumPH79Dy02TpAxFDR+9ehapG14PJOx/bLOe2kzXMfeQis3WCq8MTzQHYRKFtR8hdpymTefUra5sFNK7QLYBZ5g/OMRLzO/tVnax+XuaT/RZcrHvdHijHJ+zc6tnRsCJrSepvG9vNsm+78WKxj0IdzlVQ6XSaoVHVVLMkbM9/R0+CwFjQuHFEpXcSCZtwXiZ6j/OmCTIgdZYTvkIum3jPC5MEoRN9NcGOl8NoUUBiqr8GlqBc17pRddZyEMF2hdNLqLWXubCjDqA5ZnZ7SOsHpuvziXaD7laDAqGQd1BezpMPo80rSmaiC4P5nHWt5h7f9EkBloViKwmNZX3t1zHCKbadF6+vf+b4chmI4hMBMUlXDUOtO1jdtMaGlDCTE/tm+46iIC3rwo5iCdbpo0ZlBKn1xgPGH92gvGm5FiQnPH8ClAEk6JCsH1oZde7UCURfOdOgAiK8E0gmDb6FtXIfx9mBzAutsrkoG5SlrCEWQnrO48E8yXmLekogCFbcN7TWaS1eLxi+/3B6cdvQgqwh9uP1ZvQRw+W3A8javClt0JyBp77Oz0rO19iYtYJJWhqWxt5dzQuFhk7tP9Qr2DKMOU9A/zwg4cDhGmpampD1Wew20PZ1GGMH4+7r3jxQ95l05UUanzDpMpeYuzbwBkED2j+/l/pl7Y4QhIIXVrAU3EixBVFIzolc9zuKPKaw9PmEi3guawT/hDGyYYijvRm+Yx1rhEwbJiVh5Ou8doATJFJIgGoIMX+5XFatIXMb4MIe8nmh8py7SWYSbe3AWwN3k8or8Lt0bfkTaPDIsbp63DBbJxucleYn20DAh4pi1P0bZ7sOFV6nJc4vMJKhZI/NRp+/M6igPCE05Yzh6nvbAegHJGUgawYRI75WnuhS
 IYVGwiqog/4BcclpPbpdDexM4ThySz1lA71MPuLNoZIQWbJa41MHctNyEc6PBWR0kRM8Chhi34bZfK9iPNByWXs2y9NnaQK6fNVg/IRTHw7l/hD84rrRubQsl1p26AJskkBYnILhf/Oj3cJVMKrdH1x8Xgle97HA7XXNSHh/Lc+M4ibYO5UE/Xfg8fmYSOyg+4XQ4/3oLKPMY+xR9Y28O2AGn1g1u/gSyoxArz8eVS/IWMuK7sYXptd1efEC9eZqYXoN1rHIcv/TFpW3dLHDh0ws5Y2lmnm1HlA4St7d1ugIweYgH8zN4SmKUDW43kanl2tn7Wn6ynjzHpw6DQSt7+Hr1vD8A/mGHb9EgIzznmCgpqkYIDDncsf7JN2+0QO2pUO7ybFTeI+GAmSLCbnbnjOFiaShiB9ifspdXvRES2DLIMVznZ52xmoG29Gdw/UJ4kdMv+iITaDu52PdEwye1yLG7NfP3AylI3xvnrjODdK2WzTVkGsk+TH4yWfqdd1BgdPOy0FOerVHyx2mPt02FsTbbvK0Gpj/fa275G7/gr7MjCM3PT3yGzZIXi8sR1m42FE7yxXNZx9sbZvTpsNErC9mOQXTLKLIFx94EdEwpelvgKovGxReWsfwZ14cAlF6
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bbfb1a-39dd-4402-b27b-08dce92b9e90
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 13:01:13.3800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVv2rR/1oZeI7PqBb3GcJvheE698Z8fIQPwO1JbLOuxLboQEKLUqLv+vBT58E4n6lyjiC5pGGiXzA6RYswx29g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2094
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

The generic memcpy_{from,to}io and memset_io functions have a different
prototype than the zpci_memcpy_{from,to}io and zpci_memset_io functions.
But in driver code zpci functions are used as IO memcpy directly. So,
align their prototypes.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 arch/s390/include/asm/pci_io.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/pci_io.h b/arch/s390/include/asm/pci_io.h
index 2686bee800e3..43a5ea4ee20f 100644
--- a/arch/s390/include/asm/pci_io.h
+++ b/arch/s390/include/asm/pci_io.h
@@ -143,7 +143,7 @@ static inline int zpci_get_max_io_size(u64 src, u64 dst, int len, int max)
 
 static inline int zpci_memcpy_fromio(void *dst,
 				     const volatile void __iomem *src,
-				     unsigned long n)
+				     size_t n)
 {
 	int size, rc = 0;
 
@@ -162,7 +162,7 @@ static inline int zpci_memcpy_fromio(void *dst,
 }
 
 static inline int zpci_memcpy_toio(volatile void __iomem *dst,
-				   const void *src, unsigned long n)
+				   const void *src, size_t n)
 {
 	int size, rc = 0;
 
@@ -187,7 +187,7 @@ static inline int zpci_memcpy_toio(volatile void __iomem *dst,
 }
 
 static inline int zpci_memset_io(volatile void __iomem *dst,
-				 unsigned char val, size_t count)
+				 int val, size_t count)
 {
 	u8 *src = kmalloc(count, GFP_KERNEL);
 	int rc;
-- 
2.34.1





