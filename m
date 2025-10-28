Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358A22173D;
	Tue, 28 Oct 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667574; cv=fail; b=NjoLe/bLNCmwaDWd49qzVXYDDja1uwl7cpLm3oJoll90SfyPhUzLkPHMZPlCt0TjDf9EMGKb6C3HJInLwW8/iOwzKUoXGRBE5tqGmYp+GgxCCv5MGoPKa+fIcV8pczoPRvePZmp53Mjh8svIRYuCsagKFz7vQI2YplgwNwFVfrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667574; c=relaxed/simple;
	bh=YlwnfWow/meASZFvGKGTYVsDQ2JBn/r7PrL7DBOA6wk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A9ZYLH5Vpn2n2+XdaxU27fWT6D6IJNuVnvtlsy86PPCURUYogNMnkrOfTrF954Wdyb/7ua+nnHXnVQgRQbSiiYYMd7NCBDBGRY+kb5IxzmEEwfnNdpk/ADjilHGSjvXmSPAeIAoCzvaiDu5H8/6byZJrumU0vhYIshAVC+eBf/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K9TVs9Xt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g5rs/rkV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K9TVs9Xt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g5rs/rkV"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBDYdl015469;
	Tue, 28 Oct 2025 16:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ffsltkrJDdsnoONCZwmAJfDaTWK15Y65aPPwLophr+M=; b=
	K9TVs9XtIqYbFxW/nJhL664bYTiBkqC1U/kBt4+Pjsg81rm4OCtFWlJQCVJCnuTd
	PbKF++Kcv5Cnx0icj5qRn+m94j40HtOg8xIIWwFshSZAUwsY2XGHneLCEVSvN1K3
	GSw9xPQ3SrXY/Cg9RPdwtmgIfhV6Onl1Vjccw0GGpJOHYQ41xolAcZhYLWrS/ULg
	GA6JHCLAEZpUHdRyxfxw3wsWg3rVdJXQYWqpmr2+LVFzsLsIv44fUI+HrqMT1SaX
	2IIIOg9rplXxDUJHa1xdaKMo0AMZfe89sBn4H4jEjZEviRahIbc4pO8MWg9VENyp
	70qh1vUko/oDACzDG07v/Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4ypn3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 16:05:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SFEsYj014963;
	Tue, 28 Oct 2025 16:05:55 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08dvts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 16:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQkb7eeLBwfqADpc74UfOnL2WY6TZJuuR2VRFOPhlEKjSbNUcCCQT29BHy1C8qtS29HVCl3J1L5HeRm61iLha8++GY3xHpf+S3i0p/3HqDRohnq9c90PLuJTKXvMWHK64zGC6L/GrbGUGMtR0RZdMQVLDpZZ4oiFhThb4yLAL15FMgLmWo68Tkuo7M/xDzPMJzSS9AlyYv8qThtk3kp/ak4bJJQxAkxqKuiyBpKIQ7jeDO8BQNPGkqjTZexSZ/Wypwl4BvsHGfxNvHEc7JwKm0+7xC7UAYCFeWA+ZHwOv1PjgW/YgQGyRewOsq1ouYo2ASTCBSqBexoXOoXSIs0I6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffsltkrJDdsnoONCZwmAJfDaTWK15Y65aPPwLophr+M=;
 b=xKhLmqiTrB/3tIWcV9eejulsAL4VLbq9acxWcy+ZqQeM27w9GHfQ+uoX0rnmfKE50oqwDpEYyq81X+8ysGkhoLE8wXQXwW1cyGMYwt07GjSPy1byGxqxHa0/uQVdPqBdAstroeZB0f8fhn9utSg2oddwrnx0a1S8dVBwVGrSsDybCyConmFVjb2gx7yJdDbEZuZky/XqrGXXxw84Nsf9RoojL6EJW68OF1jnOWhscV6ryNcj2ic5VlhyudIjUpRSHElursYZreTf8XycnGFS5ARNGfD2PBSU8SJE1BzTKQZ1WvNkic4mVl7OoQgr6wvW6BKpYcnXYnfUhJDXFf1VGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffsltkrJDdsnoONCZwmAJfDaTWK15Y65aPPwLophr+M=;
 b=g5rs/rkVnEM0S97TZ7dfbXqi8phPCPSQk5VdFbttYpepy/9WENExX98mTP9S0B8PeMiGMw9uIhteJzfCWkoPLTgwRCIfqjlNtPlnezautTrA79HXaXviCmNIpL4FyRk59ACnb8HRNVk69TLd2tlEKrHIyWaIh3mX4rMbojkEaJU=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by PH3PPF1F3678C2B.namprd10.prod.outlook.com
 (2603:10b6:518:1::78e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 16:05:50 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61%3]) with mapi id 15.20.9253.013; Tue, 28 Oct 2025
 16:05:50 +0000
Message-ID: <50d815a1-8384-4eaa-8515-19d6c92425b3@oracle.com>
Date: Tue, 28 Oct 2025 16:05:45 +0000
Subject: Re: [PATCH] mm: hugetlb: fix HVO crash on s390
To: Luiz Capitulino <luizcap@redhat.com>
Cc: osalvador@suse.de, akpm@linux-foundation.org, david@redhat.com,
        aneesh.kumar@kernel.org, hca@linux.ibm.com, borntraeger@linux.ibm.com,
        mike.kravetz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org
References: <20251028153930.37107-1-luizcap@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20251028153930.37107-1-luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0461.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::16) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|PH3PPF1F3678C2B:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da717c5-f86e-41a1-6eba-08de163bdd05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rm5hUUNVRHo1Q1NPaW1raEdxbGZXUXRXSHA4MEM0MEM4dXkxaC84ZUZ3QU8x?=
 =?utf-8?B?bHZoYkw0MDVjd2tNOUlrM0hBTSt0eUx1U05XcWVjQzV3VWhqQU9CczF6bG5s?=
 =?utf-8?B?anNCT1R2RnhwZzdLWTFDVGtPM0FBa290NEpGclVpNUtWb1A0QldBcEU2QmI1?=
 =?utf-8?B?SHZ0aDhsdGZhOEprRVBsOGVzR3lnM3R1dEtMR29sanA0aDZYcFpxWU54MVNZ?=
 =?utf-8?B?bzU0U0N5TVZVS1FSZHMyWjJNTERuMHhuSWhaN3Y0eTk3S0FES2NYWE1XYUJV?=
 =?utf-8?B?U0tqTGdncTRtQ05HQ3ZzRy85TFJjdjVPdm16dWxFRFVTU3RCUTZzT3FUbnZT?=
 =?utf-8?B?R2dvdWpNU0hDeVUwZ0RhYTRoRzlhYUZ5TnY0TUZlSTRSV0hSTTVod0hlc21Q?=
 =?utf-8?B?dFlXY25pNDdoQ1FwMkQwYllxejhyN2J1V29RUHoydFpUSFJNR2E4WnZ6d0ZK?=
 =?utf-8?B?eXVXdTlXUDVrcUkxZElKenNKeHlJaGF0RkJDYVRYY1lHc1A0Vy9RUC9kOXlx?=
 =?utf-8?B?UDFMRjRaNDdGTGxKcFlucENlTTBOODJocnFVYXF3aHpyMlVNODNweHZmcWNi?=
 =?utf-8?B?OHNRQlg5bVM0SWRCR2tuWTlRUllnNWdYNW4wZ1lMQVQ2RzB6d0lWZGlkaytw?=
 =?utf-8?B?dS80eW51eEE1eTJFT3p6MXdjc0t5SzYyR0d4RTRhVEdlM25NdzNXN3dkQWI0?=
 =?utf-8?B?ZE9tMXdoTWJYY3I0QnpzUlpoalhFRlVybXdKZ1RGbEFSQlpOYWZtTHR4SzNS?=
 =?utf-8?B?bkM1RmtheG5KS1NvNk81cUE3UW8xMkFZZVU0STFic1Z6cnMrVlcrQkZEQjBq?=
 =?utf-8?B?djR4WHZ5VFhoMWFwOUZaUE5CVVpSU2dYS3l4N25JbE1aTWxuVVBtYUpVc0E0?=
 =?utf-8?B?ZVd6VGk0SkUzZ3pDSDJGdGZwTnpyWm5uaHp6Z25oZkl4ak9LaTZ5TGhkR25q?=
 =?utf-8?B?SXBRTFhxcUdkQ2MrMHA0YUdVbFdiTGVSdld0VGJFT2p4Y04zU05nRi9RSUpq?=
 =?utf-8?B?NGpGaThoQTUvRDlWVDRKU0tYZS9yQVorS2E3TFpFNmwzMWJVRXB4bU9aT25p?=
 =?utf-8?B?Y2kzMm1kZ1A2YlJNckZGem1ET0ZOaEcxcGVXTkZMQmpEUVRBUXZmNGh3YzAw?=
 =?utf-8?B?VU8wWjJGdllqWnN1eDE5dXpOa3FNN0NuMUlncGhEbmVZNXN4MC9md05zRDRa?=
 =?utf-8?B?KzF0YUFSa1dCNVdwNnpSbE9Qd1poaFhmQUdRL1l6Q0hzWnR1N1ZQUFcwUFZD?=
 =?utf-8?B?WlpTSFVrZmpQZmVYMjJ4c3dWVTVIWE9ZRWdURzRnVWU2MXBBcnJmVDBFWVlK?=
 =?utf-8?B?STNDSENVaGNBdXYxUEdBd0NrUnN1aFIvV3NTRThyQWNmc0ZpSzNpaXhsN2ND?=
 =?utf-8?B?ZWlNM25sM0NhV0xGa0lob1NpdDdFUnZXYVdWODFESzhERGVEYndoN3ZyM2xI?=
 =?utf-8?B?bDNsNjlQU09zc0psMWdKNEU4RWljR0xraHV3SFd5SWxIbkE3K1hVYUJ0NDVO?=
 =?utf-8?B?di9GWEVGL2RFdUpBakp0WDArQjFNVVdaYjVZRDU5cmVnZ1BzRHlYS29RSUc3?=
 =?utf-8?B?YUdad2xQWldud09tUG5TMjNmcnhSLzZnTmZkTVNOUnFDZDFubnFmMWtnQlJz?=
 =?utf-8?B?dTlTYmpkb0l4ZktSNlRnUkpRNTJiZDlhR0x5eDc1NHZ2K3AwM3RqWFNYWHk3?=
 =?utf-8?B?UXFPbWlUQzNWNHVuenFIRnViY0xVaVhBK1AzMkE2M0ZtRmpQTFdwU1ZFSHVn?=
 =?utf-8?B?Y28vVlFKVWQ3MHgxSFhYUjBYVUREUmIrVkNmZEl2bm1US1JOY3RVc2pkR2cy?=
 =?utf-8?B?OHJWK2U1VjRrd3p4azlzeGR2VFdqMnZwUTByMFV0Ni9tbVZvWTR1OUY0YzVB?=
 =?utf-8?B?bjBlSzdEWDU2TXIzNDRhdG9QRiswejB1Y3F1eHpSYlZwUDJQOGJ5eElNb3Nv?=
 =?utf-8?Q?Y6KIp9WGX7Ckpbx1yqE0sT65ABi8SVZV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmQ4SERyaXh0TGYwZUdKME9mSW9uSWFEcGNqQlhrZzE0NUdDZEMrWmVBd2No?=
 =?utf-8?B?ak5Zc0hhOWRLVFI4YjJONThsVUNxZDBEdHZWUllzczVSV0wrSjhjbW1xN2xn?=
 =?utf-8?B?ZzdRSkhKVEk2TVNDMStKL0NDQXEwTzNzYUtaSXVLUGdhbjFoUFFSdnRiTjly?=
 =?utf-8?B?UXhTbXJrN2RIVlVUZzZhOFZKYThqaml1bGdnZHRFendPWXl1RjFTK2xpZ0J3?=
 =?utf-8?B?ZE1ITHFaYzhPZ202M0ZPa0pNOVdCT3VMWnVOaTg2Y2dKdUl4MnF1UThJbnBk?=
 =?utf-8?B?Z2N2MWE3bVZLbU1jaUVRa1haYUg1SkYvQ3dtMU4xUEYzaXdEVGdFVFdjanh4?=
 =?utf-8?B?Z1E1ZmJLWFFDS2FRREdpZmlzMThNeE9KcVRUMStZRWFQbUtzOTJycHd1Zkxl?=
 =?utf-8?B?ODVLLzVia2VwWUkzUW5qU285S2tMUEFINnp5aUlGWlF0amhEV2NIVVV6eFJa?=
 =?utf-8?B?ZXRXT2pwemxUQndxSTZpQTc1dG5xTDUyTmhsbEJZdXhrSVJQbXlWWEVWdjAw?=
 =?utf-8?B?c0pldStIOUJYZDhVSEV6Zis2aFFKVDdhRU5sVzBUOGkxQi90UzlkSnhrUGdQ?=
 =?utf-8?B?L2ZvcWdBR1E0MjJKZnRoY0FVVk9qR3RXMTM4NmtNaUFUdlFIcmRScThIbVFN?=
 =?utf-8?B?MU5qNlFzUzRJc3M2NzR0QmJMaExLM3NGcTg1T2lUQVZFVGlPd29lL3JQaXcw?=
 =?utf-8?B?SmN2djFSRUhWbE5qdnhyOE9hZVN3Yy9OdzFkaGk4TTlNOVhHdVNWVXV0QzJm?=
 =?utf-8?B?N1Q2UGgwbktsN2I2UEhRY3NvWDdWNDVTUGdVYnlNaENGL1FLSVYvd3I1Y3hB?=
 =?utf-8?B?aWU3b2JkUXRvZnF6SWQ3eHhmc2N6dHpOenBhVEcyajlyaG5IcXJxRlZWSWdU?=
 =?utf-8?B?dm5DQkVlOVovOW0vY2pHRWczVk9YUm15WVVTNHRxL0JvZU1DTkYrQWRZdnds?=
 =?utf-8?B?bjRQZndoWUJ3RjZDenI4YnloTmROd3lkaHNwUlZGamJYeVlSV1krVFJjektv?=
 =?utf-8?B?R21QYUhNU3BpbnFhTTR4bm56U0FHa2xMbVdkKzg2RkM3UHJJQ25WaTNwdjRK?=
 =?utf-8?B?VGt6YlZZVXlibUlCQUFoYzBYcG5ONjdRY1dNYUN1ZnVBVnZhRDRTZThOMHRh?=
 =?utf-8?B?TnVMVjMzM2NrQUR3ZjR6dXVzVEJoWGVmbHZQUE1Qakd0OWF0VlQySEN4aUx6?=
 =?utf-8?B?ZXQ3S1Y5VkJDa3FjZWhMWHRqNkFha08xSFBaWE9YY2FCUkpkS0k3QTNpMCtD?=
 =?utf-8?B?UFhrUXRRYUo4T1hXb240SnBRTmpnNW9yQ0dJYnNYejRjUXBGcUNhUDBLb3lk?=
 =?utf-8?B?L21sclpYTXIrUE5HTVlWM3ZuUW9sWE1RV2ZpbjB3Vkw5UVZLVkRYWkFESjBw?=
 =?utf-8?B?N1E5QjVldXJBMUYxOVl2K3JrZXZQanBaMlVGQ3Jqb21hcURhWkptM0xSbGYr?=
 =?utf-8?B?K05pbE5hMjdUSGp1blV3MUFQQVFlbjRhRzVEZ25mclZKekpwZCtpSFA2ZTRh?=
 =?utf-8?B?dXpGamlWeFBHUUJOTzFBRjRjQU1qTGUwOVRIc2pZcGVhaGE3LzkzZ1N1Ylkr?=
 =?utf-8?B?c0FsVW56d3Q3NnRUanluRUFPUnRVQjhTQnZRcy9WcGhxa29pMDJTNzRpRDdS?=
 =?utf-8?B?bHl0d0tDTzRKUTJtTXpqVmxBanpMTXB2TzUxbTRsV1U3NEVmZlA3Y1plb1Z1?=
 =?utf-8?B?U3YxTE5wSVd2Q1o2YnhTRE1NdFVvdytQNDZoTVNZbUNtS0doYUtZSGdmd0hv?=
 =?utf-8?B?TEd3THZwQnU1bjhqbFluVmpTYlU3V2V0a1cxQlZpWDQ0NU5IQkZ4MFVOQVZW?=
 =?utf-8?B?NzRYenUxZk1KNjYzVzBqOVhVYSt4S3pmY0J6UEhIWTd1MFk4alVUZ081a1NH?=
 =?utf-8?B?SThBOXJSRHJsQ2JJcVZCRE95M0FheVd1eXY4YkwzektGL0pFQnFzUm9vMUZB?=
 =?utf-8?B?UnZMbVlCYk1kYUlpRE5rbEZWUjFWQ1hRWmFKZndYWlZQVGI1L2RXcm5QcjFY?=
 =?utf-8?B?U3phSzNLdmhWc2NZOWl0NUs4NmNWTXRrQ2EzS1pZZi93K0lxWVJWM3RSYXY1?=
 =?utf-8?B?VTk0VGJGRFFuMHphd3FDdEtlZW5rRG5ZNFNTc3pheUdMb0lubjZ0WktVcnRG?=
 =?utf-8?B?WFY3OTVGdUFQaWc5UDkrZllpM2VsRERTenFkek5nZHdXZzVyenM5a0JtWWR0?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3gD9vT96m48aWWqaza2o+g+gkGlAGl8BXLOU3JDDtuU+1ecPi5+2g1JU9qDLo76fkQVkovDo1g7lfTauIVkwJPujmw/SEERPiAPdWrSpb5cQ1Z4BJg3puZHV4zieHBMei/VUasIE7iS7ZtR8f9UqyVsp4ZWX/qRlKviE52H5mfcO2xZYPxjbKr2c8c3WyxIRzFZ5M6d/TXZKT3bR/YbL3LqrYw63a3+DXFI0VurYTvVA9DUcOYepqpz3tpJUomgaKZt7putgoEto+utAX3PhM/c51N6Aay4x3AE7RoxngaV2H4XhydXb/oEhQIKoC8dYtsH49WGK1bhI+s9S0CoNidGWouKOLgV1fHzL6c7C3p9ykibDgDnkjnze9d8ZHhvtzxjoPwU8JfMrsXQdeyZqDKFnDWFOk7o6IcS99XD5ifuteyJuPa4qqingt0gG3m5ujAla6+ABndFi/Gt27wFwBbdgbnJNEmLckgR3oAaf3YbmnfH814+cn9PP2z39Xt0yFU76qeK/SEIXPF2fSW4JpdFY8HFg+AiuC0C7g28nC9+aGhQ6gjXKaufq1Ns+GVmZeDdUmT0Mllv5CleVX4AKRnuWFuHSHiRM+4jzPjwc/UA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da717c5-f86e-41a1-6eba-08de163bdd05
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:05:50.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSt5Jqi3mhNvvJYgQz0hls/+h4u+bryt4R33wSEzH9pj9fTUHJqrpKCpXI6SUJoFNvJ+mmHhwNKBH/jxjxzf221XnMJcD4r4OzrI+9xDoas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1F3678C2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfXwlnfPvhB+s15
 w0hqBxDgnPa4znT54XmFqggvhM26W3ktpj7mNAf8k4X7gb76D/WnpOIwzzPGnoq0y9R159wMcU2
 jaFEH7q6B29aWqx/WSYmoVYwtinnbG+dP5KAekI3fE5QC4SFKEaiYZzb1b6gdAwI37y4ykLr1FA
 Q/nBhCQESWGH82YQvrgM4WIpjDLKNmHk6ZM1mZGWLniXlakVlJB6JaHLpB0p0KM/OTc0UoVIvvz
 SQVj8612JxdwB5XzBzdVIrh6jIwaBUOjs4qQWzq1dj5wSt6TtZC6+UaunlxqoVSJXclcKbe/FBi
 d7bwMOUQ2PIU/jJiD7BBTVLn7KO8t2qIdmdKfp+pOsnkaMMn0+EDIEoyGvmLD8mb3bwHGCCsY8+
 wUEeomc8mL/RQI8B3ZVLmUiaIL15xn7uItQb3U8Cz+/VjL5NiFc=
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=6900e9e4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=zr31-fQH22JNryBtlGcA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13657
X-Proofpoint-ORIG-GUID: jHdtGBvBvnCk799IfpgbdZ1SpVuuoe2x
X-Proofpoint-GUID: jHdtGBvBvnCk799IfpgbdZ1SpVuuoe2x

On 28/10/2025 15:39, Luiz Capitulino wrote:
> A reproducible crash occurs when enabling HVO on s390. The crash and the
> proposed fix were worked on an s390 KVM guest running on an older
> hypervisor, as I don't have access to an LPAR. However, the same
> issue should occur on bare-metal.
> 
> Reproducer (it may take a few runs to trigger):
> 
>  # sysctl vm.hugetlb_optimize_vmemmap=1
>  # echo 1 > /proc/sys/vm/nr_hugepages
>  # echo 0 > /proc/sys/vm/nr_hugepages
> 
> Crash log:
> 
> [   52.340369] list_del corruption. prev->next should be 000000d382110008, but was 000000d7116d3880. (prev=000000d7116d3910)
> [   52.340420] ------------[ cut here ]------------
> [   52.340424] kernel BUG at lib/list_debug.c:62!
> [   52.340566] monitor event: 0040 ilc:2 [#1]SMP
> [   52.340573] Modules linked in: ctcm fsm qeth ccwgroup zfcp scsi_transport_fc qdio dasd_fba_mod dasd_eckd_mod dasd_mod xfs ghash_s390 prng des_s390 libdes sha3_512_s390 sha3_256_s390 virtio_net virtio_blk net_failover sha_common failover dm_mirror dm_region_hash dm_log dm_mod paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt pkey_pckmo pkey aes_s390
> [   52.340606] CPU: 1 UID: 0 PID: 1672 Comm: root-rep2 Kdump: loaded Not tainted 6.18.0-rc3 #1 NONE
> [   52.340610] Hardware name: IBM 3931 LA1 400 (KVM/Linux)
> [   52.340611] Krnl PSW : 0704c00180000000 0000015710cda7fe (__list_del_entry_valid_or_report+0xfe/0x128)
> [   52.340619]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [   52.340622] Krnl GPRS: c0000000ffffefff 0000000100000027 000000000000006d 0000000000000000
> [   52.340623]            000000d7116d35d8 000000d7116d35d0 0000000000000002 000000d7116d39b0
> [   52.340625]            000000d7116d3880 000000d7116d3910 000000d7116d3910 000000d382110008
> [   52.340626]            000003ffac1ccd08 000000d7116d39b0 0000015710cda7fa 000000d7116d37d0
> [   52.340632] Krnl Code: 0000015710cda7ee: c020003e496f	larl	%r2,00000157114a3acc
>            0000015710cda7f4: c0e5ffd5280e	brasl	%r14,000001571077f810
>           #0000015710cda7fa: af000000		mc	0,0
>           >0000015710cda7fe: b9040029		lgr	%r2,%r9
>            0000015710cda802: c0e5ffe5e193	brasl	%r14,0000015710996b28
>            0000015710cda808: e34090080004	lg	%r4,8(%r9)
>            0000015710cda80e: b9040059		lgr	%r5,%r9
>            0000015710cda812: b9040038		lgr	%r3,%r8
> [   52.340643] Call Trace:
> [   52.340645]  [<0000015710cda7fe>] __list_del_entry_valid_or_report+0xfe/0x128
> [   52.340649] ([<0000015710cda7fa>] __list_del_entry_valid_or_report+0xfa/0x128)
> [   52.340652]  [<0000015710a30b2e>] hugetlb_vmemmap_restore_folios+0x96/0x138
> [   52.340655]  [<0000015710a268ac>] update_and_free_pages_bulk+0x64/0x150
> [   52.340659]  [<0000015710a26f8a>] set_max_huge_pages+0x4ca/0x6f0
> [   52.340662]  [<0000015710a273ba>] hugetlb_sysctl_handler_common+0xea/0x120
> [   52.340665]  [<0000015710a27484>] hugetlb_sysctl_handler+0x44/0x50
> [   52.340667]  [<0000015710b53ffa>] proc_sys_call_handler+0x17a/0x280
> [   52.340672]  [<0000015710a90968>] vfs_write+0x2c8/0x3a0
> [   52.340676]  [<0000015710a90bd2>] ksys_write+0x72/0x100
> [   52.340679]  [<00000157111483a8>] __do_syscall+0x150/0x318
> [   52.340682]  [<0000015711153a5e>] system_call+0x6e/0x90
> [   52.340684] Last Breaking-Event-Address:
> [   52.340684]  [<000001571077f85c>] _printk+0x4c/0x58
> [   52.340690] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> This issue was introduced by commit f13b83fdd996 ("hugetlb: batch TLB
> flushes when freeing vmemmap"). Before that change, the HVO
> implementation called flush_tlb_kernel_range() each time a vmemmap
> PMD split and remapping was performed. The mentioned commit changed this
> to issue a few flush_tlb_all() calls after performing all remappings.
> 
> However, on s390, flush_tlb_kernel_range() expands to
> __tlb_flush_kernel() while flush_tlb_all() is not implemented. As a
> result, we went from flushing the TLB for every remapping to no flushing
> at all.
> 
> This commit fixes this by introducing vmemmap_flush_tlb_all(), which
> expands to __tlb_flush_kernel() on s390 and to flush_tlb_all() on other
> archs.
> 
> Fixes: f13b83fdd996 ("hugetlb: batch TLB flushes when freeing vmemmap")>
Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>  mm/hugetlb_vmemmap.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index ba0fb1b6a5a8..5819a3088850 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -48,6 +48,15 @@ struct vmemmap_remap_walk {
>  	unsigned long		flags;
>  };
>  
> +static inline void vmemmap_flush_tlb_all(void)
> +{
> +#ifdef CONFIG_S390
> +	__tlb_flush_kernel();
> +#else
> +	flush_tlb_all();
> +#endif
> +}
> +

Wouldn't a better fix be to implement flush_tlb_all() in
s390/include/asm/tlbflush.h since that aliases to __tlb_flush_kernel()?

>  static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
>  			     struct vmemmap_remap_walk *walk)
>  {
> @@ -539,7 +548,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
>  	}
>  
>  	if (restored)
> -		flush_tlb_all();
> +		vmemmap_flush_tlb_all();
>  	if (!ret)
>  		ret = restored;
>  	return ret;
> @@ -703,7 +712,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
>  		 */
>  		goto out;
>  
> -	flush_tlb_all();
> +	vmemmap_flush_tlb_all();
>  
>  	list_for_each_entry(folio, folio_list, lru) {
>  		int ret;
> @@ -721,7 +730,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
>  		 * allowing more vmemmap remaps to occur.
>  		 */
>  		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
> -			flush_tlb_all();
> +			vmemmap_flush_tlb_all();
>  			free_vmemmap_page_list(&vmemmap_pages);
>  			INIT_LIST_HEAD(&vmemmap_pages);
>  			__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, flags);
> @@ -729,7 +738,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
>  	}
>  
>  out:
> -	flush_tlb_all();
> +	vmemmap_flush_tlb_all();
>  	free_vmemmap_page_list(&vmemmap_pages);
>  }
>  

