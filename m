Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3775FC433B4
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 16:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158BF61244
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 16:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347367AbhESQRd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 19 May 2021 12:17:33 -0400
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com ([40.107.223.81]:17121
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240333AbhESQRc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 May 2021 12:17:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoiwbB8BVaSZkncDayN9p3iuHFi55eLbAZLcWjbdZLNG+RMxVDFhIZogHlhVh5FU7c9jWpTlgVv5KmbOLejGh/RcQ4DGLHDjDBq+cyHE5Ve9rfpttk54iFL1Cb7TMn+8pqD5hNGiat/FvpS8HTMGWcbvhRI6bqMtQj0jPj3amy0JydAjD3jJgRtRAUKpylpYpA2oIlVgxzcHc5Okq0YiFXXHXIwiqQEdKU86VSeVfHhR+3T8AXgAHpYOj33rT/RQNl3NA+eGnkw8fxTttfDZ8Pv5+3AShE+OMkpkC6/7bQmCBYFrpFEqHArpnUDapRAyOoR05j1/LfyAL5UOI03BVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTcK0ozGxWWZN+CzITmegu1gO+pLoHC4OUiJscY4xwM=;
 b=Z04tgIzF5nB2+KR8HEBxjmpobEcfZ3I/JLYMA5EAV4D1hP2DXwuZsjuaGUk6RHcsNMA7w5zmwHPhW6vznOWGOD7e8/HfDknBLLJXWZ15q5kAe7j8ElOB5WkUtDBKXD1GKgRyTG2Q0Eskd3qSdLAxT1FHRc4SlhoiC3NSj24388LkqmW0+asT6PI4LgRXpVOLuhiP/HQwH45SK/v5QTxSzZwLjP0MmqVXwETR5EENWSqhb5dIq0w2y8bDqaxoHlzu0YlSo1uDch1UcqPnRd5A6c2mGL50hJj6EjTQWZNlWeeY3yrMKl7nvQDILOY0oXnwcQbplx8a5lUUAK1Ny/qezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTcK0ozGxWWZN+CzITmegu1gO+pLoHC4OUiJscY4xwM=;
 b=dIArLLXdaPMgJg+phRr6a60QXRyMIVEYfCoFbx/nzAOlJqe7SpJHETAC9kX9Bwv92YQWy5r/KmfrXfcOex/5axZJhPbCsjT2txuaQUskmklFpAG/F+A78viBRCV4QkRGsaCaQrRl/nOUib87MVpt5coZLiL83cPXgAnp7WzBhhIqrXpe7bLXvJ3fk9iHxbGNH6or3qcnDEUZlSrHsatqQUSnL+lTvjJPKYWflo5179vE+xjyOoXfuUf23kVGgLIMpUIQZxNSYgjYzjSAKkQ9WFMkxP/qLWCFzpZmStD3Hys8plJdMxSM8EHLek17fSTx6jdEYpGGy72SzgSuQFqvyQ==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 16:16:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 16:16:11 +0000
Date:   Wed, 19 May 2021 13:16:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
Subject: Re: [PATCH v3 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210519161610.GO1002214@nvidia.com>
References: <20210519153921.804887-1-akrowiak@linux.ibm.com>
 <20210519153921.804887-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519153921.804887-3-akrowiak@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:207:3c::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:207:3c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 16:16:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljOri-00Akm4-9h; Wed, 19 May 2021 13:16:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf9d9479-3275-45b6-d464-08d91ae16b1d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4265B00B509384113113E367C22B9@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzuE8YooH2sMo9iOOrMiwLSxNK+rSpbRlODofIqHNbaOZ/CLKMRXs8/Qgq4cCUEAtyCwa92soFADOkm1yUeBS2T8bU7pRP/HSUy0OgKy+JtYsNJI+wlq6RK0+dqakUEwXCTogx7j+kfFjLJBHl3rlTKmfAcQAVUaqMoMox03kTIui8jIJLt1VPZ4iGWxQFCSfFuyj6PLULCY612K+F6GAXSfnFnlthtAKp711qWe8W0qyQF0BQ2nnnGI7z8ZZ+2AKGaFw2PRoY6QBScrz0Kv3f6oEo2oHN5KrGkD2v5fx1udJ8S0SSnTlHDd3QGSuAUog038xutxUPEWjua+CXtntzOjMCokVbY62vm0wFB6fi6sDpHU6b+g7Vsa6SeMG+IlqUCIhBZ0k9OSF3s/8CduEH8Kv3S6tk2Ymc5tm5yIU2ioYSqFQ38d9Re9uj9Jigm0Uc4vIPMgEarrDOGUclZcsvCD6zdpVhsdXOZnig6WNP54J95NzFG7pgnK0d/YkprXHtysbkraBqnAAwuyHWHqqQ0G5Efr+WDNFzIhDLzJia9ISc6Csh9JFfIck0px4LaDjdJHKH243A7rlJev7kRcmsBxCYe/zhLU7uQz1vMTSzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(1076003)(478600001)(66476007)(8936002)(86362001)(36756003)(2906002)(8676002)(4326008)(107886003)(6916009)(5660300002)(66946007)(316002)(38100700002)(26005)(83380400001)(33656002)(2616005)(9786002)(186003)(9746002)(426003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SS5KnuL2Fzcn9p3/1sK4Jjfv18bVHebEVBaRT+cTcc4v7TThL/W5oRttSBMV?=
 =?us-ascii?Q?IMvx3daBe2W8Om0yAsaqtOOMtJRUe76oe4ZDWKw4Ku6jmgYqtoCyWtyvgo+9?=
 =?us-ascii?Q?hhgyZymo/fPfhPP9rJi7q8PjS1qG+PaNbZqj5KoHXbD+JIzaxXhPYulcoN9c?=
 =?us-ascii?Q?k5kREsjIgVSJofCtaOm7O6EFJSGws7Jqmn+O4JIt+Z02cGkZc1+OOMDXSyNp?=
 =?us-ascii?Q?T+jLyfNRt4OyLe9wyhcpMBA10/38xs/vCqiyhoGT10AwB8gkZFgdR0irDKvc?=
 =?us-ascii?Q?fjBzR7ev82uJJcHBxACGC3LXDyX8JoelP5Nr1FUdWdQ5S38hHl4VtdnGyjaz?=
 =?us-ascii?Q?RTbzbbupOb2S+ydZ0tliakGRJBSlwlaQZsLKcNSdkQAFOe2IE8R1iZtZ3ktc?=
 =?us-ascii?Q?874vN2E5TKyk284YUTk2srhuIHRV7H1L+oEn54+NHT7QMWhCXEgUIIR6IJg9?=
 =?us-ascii?Q?9nSPPgppS4m5LiyLg15OSFhAUCq/Xud/RaGjOchicENC+bYoNEF0dusd8S0g?=
 =?us-ascii?Q?18rY1yDER0/GihIe1x6d9vvEHnPgBIWrUo+dzbij1fbAp/2TgJc8yp0MKr5u?=
 =?us-ascii?Q?euY9d5/bilWWSH9OQRHyGVEylkCGx2UGNUzvRWWgq4rPIuEdtXRa9cnEutBq?=
 =?us-ascii?Q?5okdblWehJG/+HCt0QFjiK4n6nBhDRulJ/k7tcZcJeDbDU9GQZD1sjhyuM/i?=
 =?us-ascii?Q?+Ijg2uE0ZlYbpf/9HoMDUHFax6hzfND6q6q3eHLKQnSqXq+pDnjMYpSIGJmu?=
 =?us-ascii?Q?3djV6upqohus7/1wVww47CtEZ/ke+gxTs5A0KM9bpR/yINkuh9umX9aOoAmu?=
 =?us-ascii?Q?NtrnlyMQsKK2V9C08yWM1FDeLsFsemrMFJWVQmTceXmbaFm0AUreu/xaVH1D?=
 =?us-ascii?Q?Pdwrd06EfHVi11dq2km0ckPQb41G3rqJcX+pW35+N6OMlpNr7seCa0uldt6K?=
 =?us-ascii?Q?SUQhxoMBFm4JSUFNEv2qrU8rjnytR1rSrYXI6zRLzlyQWZll3FToY5ADvUbr?=
 =?us-ascii?Q?aGQAedW1n1oqXlG+/r3QXFZ7TgDFEpok5qgzwuZTrt9yqHs5TtOt8wT31HYd?=
 =?us-ascii?Q?cas/Bnk6DyODt9PHGDYhvJ1AEhpbdqfbdI/ogjdcrO6GizqYveWmkcaJl/lX?=
 =?us-ascii?Q?aczohtiECacn+HaoYBfB5589whJbOf5C4Khok2cHEoyjRaQKE4IZ7cugZW2m?=
 =?us-ascii?Q?ZviJvEQRxzevGMZ7hHt3Y5eAVRR4+S+qQCpwc+DNTh/opjmrUkd4mmBhJb7s?=
 =?us-ascii?Q?FsIKtf/WGCrI49JHZIqoZFmh8zyMM2zXeH1Tjjn/Ten4GXviXl/MlJbL3Vbs?=
 =?us-ascii?Q?BcTa2nNE2r/InkhU2zUbq2UN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9d9479-3275-45b6-d464-08d91ae16b1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 16:16:11.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvgw0e4DnHZ3PKnVnbodGKQEsWTFXXi9Duxtx0I+Gt0NAJx9ZzldLc5qKT/DWBGf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 19, 2021 at 11:39:21AM -0400, Tony Krowiak wrote:

> @@ -287,13 +289,17 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>  	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
>  		return -EOPNOTSUPP;
>  
> -	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
> -	mutex_lock(&matrix_dev->lock);
> +	rcu_read_lock();
> +	pqap_module_hook = rcu_dereference(vcpu->kvm->arch.crypto.pqap_hook);
> +	if (!pqap_module_hook) {
> +		rcu_read_unlock();
> +		goto set_status;
> +	}
>  
> -	if (!vcpu->kvm->arch.crypto.pqap_hook)
> -		goto out_unlock;
> -	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
> -				   struct ap_matrix_mdev, pqap_hook);
> +	matrix_mdev = pqap_module_hook->data;
> +	rcu_read_unlock();
> +	mutex_lock(&matrix_dev->lock);

The matrix_mdev pointer was extracted from the pqap_module_hook,
but now there is nothing protecting it since the rcu was dropped and
it gets freed in vfio_ap_mdev_remove.

And, again, module locking doesn't prevent vfio_ap_mdev_remove() from
being called. None of these patches should be combining module locking
with RCU.

Jason
