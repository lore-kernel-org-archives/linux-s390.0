Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954DFEB64D7
	for <linux-s390@archiver.kernel.org>; Tue, 20 Jun 2023 19:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjFTTQv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFTTQu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Jun 2023 15:16:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2096.outbound.protection.outlook.com [40.107.243.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B19D1B6;
        Tue, 20 Jun 2023 12:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehBQpzOt8upB+R+jH7OOkhe6MSuNgQC3fG7gVAqRskwQ4jS8JINhiGzJT9fCDjIIJwnVn6ylYcJcmbq/Z/DI3pJfRNrTF2ttl1khzO94kR0M3lmjFICictsH73LgnF4kxW+S/TD6W3ZVSRVyizb72LVxHGQ5hSfbOKcRUVqFcz4onFA4tv4RTLe5OCNL7pTJc2gXFazvmiJWfIDrltNEnaiXCjoeJfj3RvPO0w8LdJDcl3IGh6Ryl6jGCOX09GcXe2Q12oSYh/zhDornrUgrkqrp5R0CS1a/+Wa9/i+KipA++fl5mgTr7+Of+VnBCJXEKID/3SPcwcIC6tjkHuSzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRiiKXdpUPMWj5qpJW5OPVoS/mqVspDpRG5+wc9gTDs=;
 b=JpZ5hD5bLXf6tEq60RpwKEbxcq19f7mQ4MtcPWiDgsWvz3rj2W5ov4dpR4pXAS7j9ffRSuzMgsWKPXQTsLcPai52us0aQPinJW/QehgrcBX+nl4zLBiGaNjTdo+51hi0x+Y4C4qpRqIkvrWT+OJCYXOacwWvRAca5biwYHUCjM6dBVfdmx2y8/PoyY1kfoYOisVg23GVQILZfOC/3lxpPS3qX3f1CH9Xs2MxUliS6N+8HD7mIXTQDzIO5yAPO5qgF48d8gVZo81KdOWZRbPQ0iUaocae0ezSD7GxXkVKPpgC1gHzYSf1yStUrZ0rnzrVhM0gw1eqjRDyMktq4EtRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRiiKXdpUPMWj5qpJW5OPVoS/mqVspDpRG5+wc9gTDs=;
 b=P6ZWR27VJBB2k68uBHbsfblKXXQfKObiWmJKnrkaQ3em3aDXh8apJR/niqIDsH05W/sBLqfGpdGDhz8lVUhjMEZR/XnnUpT4g83GQgZ7+ruFnQ+87HuaNjBTLHrhZ7dIMRIir41bBjkuRqLLhIkQHYaaUE/dbiw08YzmITbIf0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5693.namprd13.prod.outlook.com (2603:10b6:806:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 20 Jun
 2023 19:16:44 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 19:16:44 +0000
Date:   Tue, 20 Jun 2023 21:16:35 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Jules Irenge <jbi.octave@gmail.com>
Subject: Re: [PATCH net-next 2/4] s390/lcs: Convert sprintf to scnprintf
Message-ID: <ZJH7E20GZ1YH8HSd@corigine.com>
References: <20230620083411.508797-1-wintera@linux.ibm.com>
 <20230620083411.508797-3-wintera@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620083411.508797-3-wintera@linux.ibm.com>
X-ClientProxiedBy: AM3PR07CA0072.eurprd07.prod.outlook.com
 (2603:10a6:207:4::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: e974f727-4d38-4f4d-495b-08db71c2e1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rg7P2PpbRYmkoe9m+E/OgLQFEUwNOCi75CsZoV51R4tc4gynlcF8ZCigRSlms8tLMUEpmIXmX6DMZilVwkqFx9yhlnLleX2MvXFTlwzD7LRLP+57+ewY5cuijb4lriGJkwL4gkOWNpMYq+QJR0kTQkRua6iaHn92TwPdGX21Guhra/QLKHAl/Q7qhnK3ReRgLkCcIJOswtjnD/9CQNpP/SkJhnra3fBMZdvO1lU+o5VKNmUkyfmHuGaDKJ6ORmy7DFF5B9Yrn3L2ocW0mL/sTlH6GvuxC21VyvpcGSmnuQAsBDjxXPyBsPQlcANVuKVm/Wsv2fzVeeMoXSMGW8DdehGfNQhjpOGWCtLvrE3jo413yPUCoQWj+hBl/XCNWmCOuyXrStS95Pm6CcTamHv0PRJOZ6KmLn8Zb87Cbcv0lKjNuaoewkpH9owu4BilxZYVdum8nWlaSmaSWM7FAa8pkKl0kHJZ0OqnsGoDej0ib0LbVGR8jsRbwzyl1EynBuBpHckBz6KbItcAWQrv6ZWtIrIfZlMZsNPEmvMt76Oa8XK5naCVRw+0ZX9TPvWka8R5PG8XDPOYe5LorgR+TvMJXqYF0JOxBwZ0IGBAeKcIGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39840400004)(376002)(366004)(136003)(451199021)(7416002)(6916009)(4326008)(8676002)(66946007)(66476007)(8936002)(66556008)(316002)(5660300002)(41300700001)(54906003)(44832011)(6486002)(478600001)(2616005)(38100700002)(6512007)(2906002)(6506007)(86362001)(186003)(6666004)(83380400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WiLEo+Hs3GH2Mk9+xLuAmvgvzuT0my8Ab06W+RQW+X9mLkfwFx9OP8sz7eLB?=
 =?us-ascii?Q?4NRy3lDHAiqpBQQwnyjSGLWandD1KPhGV7p12muJAFEVyFTE+1qWPMZnL3Vl?=
 =?us-ascii?Q?85B4VGObUnXmoj/Is6F5mOfvEBXqDR4V2mIHUlS2X4MJJT7B0HJKw4Ctb01U?=
 =?us-ascii?Q?AKcj3DVJ7A0F9yDPLP/ws/ADrO16thsYdbqmLXpZ2RmbzseCwXjLLIYSxdw5?=
 =?us-ascii?Q?i6ISC199d3wQ0Wjs3o7ExcwS9VlBNgHl4yxPMgQdeotEyXiLFflpwcPOiT5w?=
 =?us-ascii?Q?AE/ZSQGJTE+TvmyJe8Y1RBptgA0Y88QSUfpIdFo38q9+qj9xa2GPi8zUWtU2?=
 =?us-ascii?Q?qDLFCmpT/WnonjFLSH6yofUSkEhGSKt2p7/vdmSsZmioiaGxK2BwAQThG1Tg?=
 =?us-ascii?Q?bRTeKGUY+RJzkU6FQ1a4bN1vlGTuZl2VrlwRbLLo/TfiGOfM3HEcE7MlYOEP?=
 =?us-ascii?Q?LaJ9V/OYNJuFZx/sh3z6WbLj8Etvy7KHrHT12QszRVnti2mL9lkKuztQeDdT?=
 =?us-ascii?Q?pKsP37d6tqNQDXIyfD+gRQzE0KeDSmmpZLkaLw9QFojJOuSCR2YmCzQdwfb2?=
 =?us-ascii?Q?u3xahNmmgcdw3UWoDV/uULSyUkVcDFCm6n/aUFzheL7bmf3bwm9WwaRM+GOe?=
 =?us-ascii?Q?z80YcUUPnQOqe1lggvtJhXp3NzV81MG50X5h6lHvbuPrAkIO3gGd23NDIAfK?=
 =?us-ascii?Q?wd40PHfWUqU18CwGldkLcNHfRUSxWlKc0eoYh9fd1TAkJr01DbcKaxhBm4hF?=
 =?us-ascii?Q?a7qHPesrJuin7stUf+5o97bIYrGnWHX9bt25VfG9Qe2Fbd8nvcUXlRBrmXhq?=
 =?us-ascii?Q?cqPLJYVVoCw6LFKb9L6ucLyEJ7iM6cpsFd6QqJbwjjdKRH3aplbEUF0/6isn?=
 =?us-ascii?Q?dp+PGLR3X73g34tIkgtl7nfkSAthrbp64w8hdGJnyrrgIQNNnl7apkBcepAv?=
 =?us-ascii?Q?7WU0RoRfjZEJPxcwxzONx+eMlrycqGPsaIr5TI5HUKnKAA2exPY26H+/Wj+/?=
 =?us-ascii?Q?m6kQ4S3aYAmqFXHrZQXVsV9sjfm9ive/KpFngnfvmVlYBeYTRmu31dmNRrX4?=
 =?us-ascii?Q?ADxyCEv2MSK8LBLNiEgYbMAzOa+ecwfjYfEuVhf9qYyrQ1KuzhqkBClk1Od5?=
 =?us-ascii?Q?KqW5syE7Pz1c6qB64UvtRUGGaK/qhyvJSPz1SCNuaJVuhVGRWa0WL8MSi5jh?=
 =?us-ascii?Q?f1Sfpb5f6Z3eKBY1iD0TnlDHC5vS06fhzkPcmlklJQUqRQCkjuk34M/Adb3c?=
 =?us-ascii?Q?BXKNMw2msnDB95vM7Qq3iAicHQZbsFuuI421KjicjEA+FNxHb/S2UhcTIyNp?=
 =?us-ascii?Q?A0gVGin30LTeY6r836xdGOH6xhePl/zE9f858YJiwELo2zEABMHvioHbuts/?=
 =?us-ascii?Q?61PxjKAcmYlpWNuNdAJQazNCu19qN600OwVwn+N8+9pluPrU9Io9gnIMCvCT?=
 =?us-ascii?Q?xL0Vs72gPpdD7nuiWlyHROe4fMjKugz2At4iJeTvrMtCLgSLyNj34+wSUwIL?=
 =?us-ascii?Q?aEA5QGH0moDK/IF6MlmX0ZrUIYjnmnBoCPZcnIlJ9sjkx/eN4PjRLGmjf78Q?=
 =?us-ascii?Q?Nj3rpZF6DuVNX5hiF4ZlvSwd4Qj3eZsgq8Nf2bGLViRulkTaK/QgBQzzsvvV?=
 =?us-ascii?Q?9QgBf6z9/0gDrA6yNLAbU+JxF8uBSqLlFF06t2UNZfdymhsPq1+dFjefZ8+7?=
 =?us-ascii?Q?RQ4ppA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e974f727-4d38-4f4d-495b-08db71c2e1de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 19:16:43.9409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6uT/qe2oq9BQZ0XkaBF2u2v3Rw7k/o2fxiDdqziG6lBm5Q4MQH1hRkhyIZ1A5qlvvQOhAOw8VgU/t9i1lw3AMikiBKN6mEjP6LCRNUgwaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5693
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 20, 2023 at 10:34:09AM +0200, Alexandra Winter wrote:
> From: Thorsten Winkler <twinkler@linux.ibm.com>
> 
> This LWN article explains the rationale for this change
> https: //lwn.net/Articles/69419/
> Ie. snprintf() returns what *would* be the resulting length,
> while scnprintf() returns the actual length.

Hi Alexandra,

Although I agree that it's nice to use scnprintf() the justification given
seems a bit odd: it talks of the return value but it is ignored both before
and after this patch.

Likewise for some of the changes in patch 4/4.

Also is it intentional that there is a space in the URL immediately
after 'http:' ? Maybe mangled by something. Not that it really maters
AFAIC.

> Reported-by: Jules Irenge <jbi.octave@gmail.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Thorsten Winkler <twinkler@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  drivers/s390/net/lcs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/lcs.h b/drivers/s390/net/lcs.h
> index bd52caa3b11b..a2699b70b050 100644
> --- a/drivers/s390/net/lcs.h
> +++ b/drivers/s390/net/lcs.h
> @@ -21,7 +21,7 @@ do { \
>  #define LCS_DBF_TEXT_(level,name,text...) \
>  	do { \
>  		if (debug_level_enabled(lcs_dbf_##name, level)) { \
> -			sprintf(debug_buffer, text); \
> +			scnprintf(debug_buffer, sizeof(debug_buffer), text); \
>  			debug_text_event(lcs_dbf_##name, level, debug_buffer); \
>  		} \
>  	} while (0)
> -- 
> 2.39.2
> 
> 
