Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2089.outbound.protection.outlook.com [40.107.255.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94617580;
	Sun, 29 Sep 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727597048; cv=fail; b=T5w5shuVR3YswroxD+UHa0ksgMO4kgr8gU7RsnYqXYx1UZl94Lslbb6nEGvJQrF7S1nQS92A/g9U7oE44Dfbo0mdPqf4rByniaS333QZLFeLsd9li4MVeXPKJW70o79Y6jjm6evosgPQ0dZkzxjQ94mBGMeBQoi6Wqv7x0rYchY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727597048; c=relaxed/simple;
	bh=KfbAC8oppMh1FHC0/FhDwgHGul6uXkjrmYnIgG0LiXE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MVltf2WR88p2b1p7cCgyQ1cdX6PyPTi1XkpjviUHqUOwu+7513JtUm7+A472ds4I9hPxf/kYB0xCOH5H3Mg7redJBYK+BTFEsYaqckyagkL/DHDpgKQbPs6hvnff8yMa1eNuGiCjm+PlUpjL1/ng7IlCyPviz232Rfk40DIySkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=q6pB8Ey9; arc=fail smtp.client-ip=40.107.255.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="q6pB8Ey9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHbg7lFEy9Siwhx8koQpOtwYHmkWjwXZBkuHa8p3HSvFNIv5zq2hanUpJ0tmLXy7FOrALyPB0E01Pa6C7ehSUyljVMePRuyc+9IXnEHuY9b+LhFicIjcuT3KAcoTtqKpJMilEogJs1p5+QoEMDCErVG+v0GunVl3/NZ/5tZp3II13oJzKtNT5WL1YReirCwI8rVH+UWgSfBru3QGKQnWKRdlZyHTPHHvGc8Oje0Naw3eag8Eet9m0kFw8NheOvm7xvsHoNHO4uw6cksTgtgOePzaWdJW20wLYIVkba4TET5Sv21GUH939sS8i2ypiQaQeIKJpH+S9WfOx6HlQ0N6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3p/JZxTUjsQ6LnWju1zBjsQQE8jovd4ezEI8rkaN4E=;
 b=IVmOCL1+fGo6R2rl52922Am2NRF7hdu/39npKjzD0ej38skkI0gYaMeH2dPLAAnu+SzZ5plmsZpFCjC9bNku4Boh4ShkDgBiJJEZHpk9/LWgmIp9n/ocR8Jjo9lBSuVBZri+uzuXP0AWVHKtDlm5yhzaAx6ORmPGp7TqgspXdWrBA5Hu0LdnTKpQXcP3wPCJq3mevrMpYxQOHvpT6L8tWVbLbiVD7NfK80DEBpU+paFK6k7lmuII3j3XyQB1fjxJSbejTpzVfmFgj/yz+Ith3l4sVWCfKqVgjornvNE0hVdRZV1iUzrjKskpAHlR0NeaOoBOvQHGnKgHwnSTWQyCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3p/JZxTUjsQ6LnWju1zBjsQQE8jovd4ezEI8rkaN4E=;
 b=q6pB8Ey9BZeCBAmYT3ZbbW57OssJ5ZRxfOzGiw11KaRUcvz2oXlf38ak4P5iIw8s2mcjQmNl4TnvvY0CUOOF2TznGipM9P99JzX0XtZCCFIYn12427IWm415eb85WulP/9qXmMaS+/A0r+e7fcIgIDGbQmhWfV/mEPPDJxZve93W0Z3DeGosracAkhfDxgB+q4TLtHcIvhKvodsV0SnGZ+6tqNl5STSeGsjkfA62+bG6VidJRNpZknjM3MhpBPI6ssm4hUtixjfwH/7Gft9X/jR47mK3W7Op7lAI2bA9RORzsDeuiF2IBgiijGjO2kKaON+59cSgaFG17P/ITz/vdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEZPR06MB5764.apcprd06.prod.outlook.com (2603:1096:101:aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 08:04:04 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%6]) with mapi id 15.20.8005.020; Sun, 29 Sep 2024
 08:04:04 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: vneethv@linux.ibm.com,
	oberpar@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] s390/cio: Correct some typos in comments
Date: Sun, 29 Sep 2024 16:03:53 +0800
Message-Id: <20240929080353.11690-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:404:56::25) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEZPR06MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a01c94-b1a3-4765-f5d7-08dce05d491c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k2jqiAnKSFIwJ8R7ddm60wvOJ0J7Ul+PziaR59YaByE1b4J4my1Bb2uZSCEI?=
 =?us-ascii?Q?bpn42eGx0ACsfwBIvLCWxFDLKlgKuEWldy06KZMTFY5Ht2KYEhIeJ7DSJ3XU?=
 =?us-ascii?Q?eU+54eeCPdvfzkLnIgn/ud4J9qXYmw7oDcjTHYLtMI2EOUjfxRrjU8VhK6xL?=
 =?us-ascii?Q?Ze33xhzm2j+qXVmYj07fBHDmqGt8Pt0dNo8d127wCxpAWufQFqfMhiLJ2WtA?=
 =?us-ascii?Q?+GWQOKynKphX0uDvGDB+gaxoDVeU6ZcBaa1IXsVwxCBYCJSFiD01k+askSHM?=
 =?us-ascii?Q?VFo0Dj0Y17zJliObfxSXF3g8x55WAIwMqFukAIU+FxpgUxM5cJYlsLT/MLfI?=
 =?us-ascii?Q?H4oPDRHkJPu5TXGXf49zbIOxelIEKpIRIw/rnxmUmHj1u0kkuUlN7Qqt2I+0?=
 =?us-ascii?Q?9Yo03fuDplZqdDUrYwv/84LM3VA6zsvqgqMlb0Yk41jMnQcxqbkvJOiE76sz?=
 =?us-ascii?Q?/S4vWU9N3KkVtncmGcq/AFekdyUo/103Wl/zuLIAlddoik/wGRo6yU6wvb2+?=
 =?us-ascii?Q?kXwHyvEnZlqIj99dE6wWiKokKYtz1qFDjTuwvInmkejuAUO2tAoXCRUTC1Hr?=
 =?us-ascii?Q?AgaiK7zdMQAXvfE78YxpWLLiB3ksQwuerZnOFAV2lKZ3WzYROKjSkG63hgJo?=
 =?us-ascii?Q?FTFMb1W+mpeBCqCRxvKnb2lX9KnRegQdqW46BkwhROHiFPOgpz4uDhz09g68?=
 =?us-ascii?Q?w0MRGk8OqSJDf1x4+hyWomexSYgOVShgkjy12gQ7clGM2T4DK5G4A3MRTJDN?=
 =?us-ascii?Q?EU8AsoJ+mlUsiLbf1IGYO8CcoI742X/4mU9Da5Oy6PPvhY8/7JiIe8d4jpF7?=
 =?us-ascii?Q?sBOm2ZQNjmFpQiN75gyv4zMO2MDlhCrP19PzFo3YIf79EylsuSLM97WkXaYb?=
 =?us-ascii?Q?rzhL6ot0oX0HPOAhlpVdrZweCj2ab6dd/wxPyFIGT0CGM/G7BmmVsjSDtjro?=
 =?us-ascii?Q?74Kt6cQuEH5Soz6qZnRMaaZTTXxsuXghJY5+4Rhwj8MWTg+6OHsFacqMxUJK?=
 =?us-ascii?Q?jmd/UUjJLy1b+nIK+PXoMSgMx+3xJipbDYxiJVHHljyWPLm+fk555wKRNC7O?=
 =?us-ascii?Q?3mknX6rLTrk5PQrX0kTo7ygsE+GSVDBBgLfzrIUOpxsZcwAxLpQRKIBtNHuH?=
 =?us-ascii?Q?wYQL7drix5Gg7YW9n0mhIaTHU26KDlyAO9zqrl8fq98ZsStkiNOzY2s8ixny?=
 =?us-ascii?Q?A23omcvGq7d4W0Os2MtefZENcwYklXxMLlr0NPDHovBkLhcJ6ea29vTKWx1z?=
 =?us-ascii?Q?iO+Y9SDNmV6lN7CnGhEh/oUP3A4B2DUFyeS+Bqm9b1qureae7uusufssqOUT?=
 =?us-ascii?Q?1vewLcqfywAUKHblLgpHaRu6ykkmJf0wd7BdldryFdvtJkT/PbYfjMhxx6CO?=
 =?us-ascii?Q?2S4m2R2egr3yO9X2LR3IdjMDLlN+6ARyMEO93DuY9hptdrGBgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W09T36vs1Bfzq/VFtbpL37RJgCQP6da3R7VhBhAUdN+dGO9dDA5T6MsPwWA8?=
 =?us-ascii?Q?vG1ZQTOqgxXqaghnnEdslsxa65jd94YnLAy1NNJIvSyB9dSKwbb58zjcCWvi?=
 =?us-ascii?Q?aG5vMoXUgy8G3fB+sWoWVbXdlFQbn4+/ceqpWPmk9QE0KoAMN+dS4VOmiTgp?=
 =?us-ascii?Q?Gar86ArXwQdNX7qXbFQOk4xRg/5/pMYugcp39D9Dd+V4S7yRIeAkhwdxYpNi?=
 =?us-ascii?Q?iXa9wK80DxV6k9F/EAgR54xIuNFsHxkSZmTbHBk5TE0bghShhOs2TGw2KZTD?=
 =?us-ascii?Q?YAoI4LEczvcy2X9t0VgUZFbHkaJeZemTNTt7XpwE+ZtYcm41tcz8VcdFxT7b?=
 =?us-ascii?Q?+Xl4FNc1SAvbCS5w/HJ/rADz26MrVy1IFfUUSIG4tX8VvGulk3CwtvBWWUB5?=
 =?us-ascii?Q?82Sm54mMY/8RxFNgVDZf+BeWiQDdkc9TXhKGDcltFfgnBPWiBda6pg70+53Z?=
 =?us-ascii?Q?ldLpKwoB3TE9nvIBC2ZPTTg6KGh4FCqAPpLvE0/RlRS14PdIceqKxphO0Lna?=
 =?us-ascii?Q?aRsr2s0xPFvpdCGJLSVSISDbd1P0G4o1rOZIinN/JgMsACPYCkWvZ9nfTAtn?=
 =?us-ascii?Q?IDKVTi9lARduOs5UUUUQ9Fwj5I2TLFcd/LC1K+6kLPEj0UsjfO1tJsmr6kp9?=
 =?us-ascii?Q?lXOFDePKWj1Qdyc4oXldNWEuWgnp8hveWOewJOCHsokVP2Wb+IAKxgXaz697?=
 =?us-ascii?Q?Bz9lh6hshttQ6aM+GmQqXIg60mAKeFOtkodLdVv4xU6pdB9eyhNQA4/ixChC?=
 =?us-ascii?Q?rP96KOSrQAHvAoeKDZmmpIB9DbI/PW8Gb47ylc7u9DPtlDGp2k8bcQyprESc?=
 =?us-ascii?Q?FkeHD2nu63Uv8lwV5qkhLVaWEsYkMXGQh6uR9IPKCiSUd7xclaTTtOIUzG7P?=
 =?us-ascii?Q?AyXLztHpl07/oiSbtzDxIeYtajeVz0jFgQWxTAl0VIHxY/ttAJQguD8Sjz8D?=
 =?us-ascii?Q?SgjqPBWpteLNn8OnrUCiylysyjft+N+NPfasDs+JPI9HjtrggtD1gwiXe0EX?=
 =?us-ascii?Q?259juELItb+lBCYfbNi9KIZXsPry/yPSqy2/DvQQpNSai4ZGTHueoYfj2kUO?=
 =?us-ascii?Q?LyD6GCCwOqPwLFVKOqBrO05QkhSTHqHr0WUE7Daq+kweNRSM1P0Mo2z1NSxQ?=
 =?us-ascii?Q?tSqPz8gYUAJXUpLCF7J0bGYpD89ArKJ7OJuWaVZWeLVxvaxzGGF9bJOrzbh8?=
 =?us-ascii?Q?dIjH7RrxVItyTEcfuDU0INYgdQCfkEeg5+FORKNxzpfbcjqTo6kk4uTOxnFp?=
 =?us-ascii?Q?HBh7XTiN/CrSk4aZnvwDCo8GMgNunB65jGxUDUiMmNpgP04KpCLcu+JZ0BwH?=
 =?us-ascii?Q?ztBxS/HGHZ+RjHq7d1OgYvN/qrJPHpidOC/6OzUzBS/8rZ8NY5gWQ6sdOZ9u?=
 =?us-ascii?Q?rkSXJvCvdfx9FVgzmH/jmrIlDIJ/5ZYikHNJWe3rNQdpqx1tbpBwK4gli0qb?=
 =?us-ascii?Q?9RCM46ZoTqeDO8sBQJchpEDeRZ5BwKekrvqr9UVT4D8KttYDT9t7sifHnpwN?=
 =?us-ascii?Q?vL2lFQfbcudHA5J7MduQpw82oVK79Ps+s9+FXJhrJOgUVgN+ghdlBg7TFyVv?=
 =?us-ascii?Q?O42kv47MjW9IE+RGkxods1liNaYb6jJ4C9FZmLAq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a01c94-b1a3-4765-f5d7-08dce05d491c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 08:04:04.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+sMQHZHZt2HlWOQs96brUqevcUp0Uu+OZ1+kqL1EPZtJM3dvxK6daOuQt6KWmuVHbxRq2QkjQR9ovlTYj3O7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5764

Fixed some confusing typos that were currently identified with codespell,
the details are as follows:

-in the code comments:
drivers/s390/cio/chsc.c:379: EBCIDC ==> EBCDIC
drivers/s390/cio/cio.h:22: sublass ==> subclass
drivers/s390/cio/cmf.c:49: exended ==> extended
drivers/s390/cio/cmf.c:138: sinlge ==> single
drivers/s390/cio/cmf.c:1230: Reenable ==> Re-enable

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/s390/cio/chsc.c | 2 +-
 drivers/s390/cio/cio.h  | 2 +-
 drivers/s390/cio/cmf.c  | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index dcc1e1c34ca2..a86b05d14005 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -376,7 +376,7 @@ struct lir {
 #define PARAMS_LEN	10	/* PARAMS=xx,xxxxxx */
 #define NODEID_LEN	35	/* NODEID=tttttt/mdl,mmm.ppssssssssssss,xxxx */
 
-/* Copy EBCIDC text, convert to ASCII and optionally add delimiter. */
+/* Copy EBCDIC text, convert to ASCII and optionally add delimiter. */
 static char *store_ebcdic(char *dest, const char *src, unsigned long len,
 			  char delim)
 {
diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index a9057a5b670a..08a5e9380e75 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -19,7 +19,7 @@ struct pmcw {
 	u32 intparm;		/* interruption parameter */
 	u32 qf	 : 1;		/* qdio facility */
 	u32 w	 : 1;
-	u32 isc  : 3;		/* interruption sublass */
+	u32 isc  : 3;		/* interruption subclass */
 	u32 res5 : 3;		/* reserved zeros */
 	u32 ena  : 1;		/* enabled */
 	u32 lm	 : 2;		/* limit mode */
diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index f80dc18e2a76..314d53d365d1 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -46,7 +46,7 @@
 /* indices for READCMB */
 enum cmb_index {
 	avg_utilization = -1,
- /* basic and exended format: */
+ /* basic and extended format: */
 	cmb_ssch_rsch_count = 0,
 	cmb_sample_count,
 	cmb_device_connect_time,
@@ -135,7 +135,7 @@ static inline u64 time_to_nsec(u32 value)
  * Users are usually interested in average times,
  * not accumulated time.
  * This also helps us with atomicity problems
- * when reading sinlge values.
+ * when reading single values.
  */
 static inline u64 time_to_avg_nsec(u32 value, u32 count)
 {
@@ -1227,7 +1227,7 @@ int cmf_readall(struct ccw_device *cdev, struct cmbdata *data)
 	return cmbops->readall(cdev, data);
 }
 
-/* Reenable cmf when a disconnected device becomes available again. */
+/* Re-enable cmf when a disconnected device becomes available again. */
 int cmf_reenable(struct ccw_device *cdev)
 {
 	cmbops->reset(cdev);
-- 
2.17.1

