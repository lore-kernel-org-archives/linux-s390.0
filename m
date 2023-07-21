Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6578C001DC
	for <linux-s390@archiver.kernel.org>; Fri, 21 Jul 2023 19:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGUTo5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGUTo5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Jul 2023 15:44:57 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C6E2D7E
        for <linux-s390@vger.kernel.org>; Fri, 21 Jul 2023 12:44:55 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-346434c7793so2931395ab.0
        for <linux-s390@vger.kernel.org>; Fri, 21 Jul 2023 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689968695; x=1690573495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4JV3T5b8TbQqqDK/BVYCQtdyggJjpPOgPu1aX+qbIw=;
        b=l8oREEe30c/6jl4ASOx8eoiEi8J0YXceXHp6NBmZLfqGg8WdCRNDKc2Dx+O3CJPOF0
         Prr1TBL/uBSQ9CkIXVZYWdwUnkqeR1ON7SwhqdlLXB9aw0w++T7AD12u/EU201HsvM+D
         5qPx2xhmmq401qwubR7w+F+d/HiWL0cu8ye8MI4f9nYrBKvREakx7irR918bhW8vqKss
         m/OKoj35KJ5c56Cv9WteGxrb/y/FHSN7ovwCYDItsKIvK+0hbJ8j4fkDosWyjnV+aBHH
         EtbZ3icsiFYvH8NGr4CYi3T3llEK8H8KcJcSBAao/YV0ZigbIUWqoNKIlVkrzbZA+z5P
         QmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689968695; x=1690573495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4JV3T5b8TbQqqDK/BVYCQtdyggJjpPOgPu1aX+qbIw=;
        b=kjMUetrL+nKgtldsF65yjAfCbTjazcJcOAXrdZNK7vgH4z02ehTvxYiZjTY/XbvQqY
         knH7GBSfE0AOobCe8XuepT3osW4pbNlFOj2coCD7iXFDku2a83cKHrMIf88aCpgOMQD/
         zcz0GPzTVlp8v0awDD/Rzzhd/k3QBjeYsXqvkc37l+7NVo1QGnZw6iuMgRKnvckFrmx1
         vVQcM30fdGkCIPDafGy2rR8Ks3ErB3t1i0ySBjgn8BFYXb4IiCKwV4yDIBKSKMZrUiZr
         AuS7uuC13b2+AXOjhTXBrTl5DbBpsr0ilr6SgMYihR8lJkQTfcbBP08uSyVF685zVwIV
         WWuQ==
X-Gm-Message-State: ABy/qLYre+XEu76rd3iG1LqZUUO+D9Npb+pEn5EGCQrvIsFuKT/BbXgH
        qgl2DvwXALQwEnm6NteWrKdlAg==
X-Google-Smtp-Source: APBJJlHh57kNFvHniHLhEStgOH9NnIcwIeYoCvzcO/4sTXVbqJP7vucQP0hit+9dxghi2VgAK4Zhug==
X-Received: by 2002:a92:d44c:0:b0:345:ad39:ff3 with SMTP id r12-20020a92d44c000000b00345ad390ff3mr2677303ilm.3.1689968695018;
        Fri, 21 Jul 2023 12:44:55 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b5-20020a92ce05000000b003460b8505easm1181877ilo.19.2023.07.21.12.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 12:44:54 -0700 (PDT)
Message-ID: <42f33274-6877-1e39-1caf-d8ff0a9bc357@kernel.dk>
Date:   Fri, 21 Jul 2023 13:44:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] dasd fixes
Content-Language: en-US
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20230721193647.3889634-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230721193647.3889634-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 7/21/23 1:36 PM, Stefan Haberland wrote:
> Hello Jens,
> 
> please apply the following patches that fix some errors in the DASD device
> driver. Thanks.

6.6 fine, or were you targeting 6.5?

-- 
Jens Axboe


