Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF782C4332F
	for <linux-s390@archiver.kernel.org>; Wed,  9 Nov 2022 17:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiKIR31 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Nov 2022 12:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKIR30 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Nov 2022 12:29:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAB410B9
        for <linux-s390@vger.kernel.org>; Wed,  9 Nov 2022 09:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668014903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XW3hyf1ELcPigroVZADXI+g6jgObLwrHXveAl76MUtQ=;
        b=cqBGfmNy33B8wWhh7KP3ZxSYBrq7OLwQsxlHDKIPzDUEuBiOsvx9VXyBrXos8kZpxr2n/k
        og7ggdM+W17Qt284Ht9XXb7H5EIB3EbmPfnGw8OoRHN9uoYvxDqeKBz29ZI+whrRJtiGqA
        n0MnLATOuLQLVXnBgF0rcj8vhel8eoA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-T6cCX_nPO02mC1RFUYGFJw-1; Wed, 09 Nov 2022 12:28:22 -0500
X-MC-Unique: T6cCX_nPO02mC1RFUYGFJw-1
Received: by mail-wr1-f71.google.com with SMTP id m24-20020adfa3d8000000b00236774fd74aso5165137wrb.8
        for <linux-s390@vger.kernel.org>; Wed, 09 Nov 2022 09:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XW3hyf1ELcPigroVZADXI+g6jgObLwrHXveAl76MUtQ=;
        b=w2G1Z9Kr1boLpbSmM0azHk5H5VILdbCFWhnwkdwGQOslx5fzaOjQN92Y/z71eYuI7G
         pUqxvj7w6w1KyKv30Yy4JcYtLJvY1Q/dEbb7ovXEnH6UwXZS+oy0uHl1LL3U5cLdpX/e
         qN8gU/iDgN6U70lYomMGesvxs52+G6vuJG6o5knK4HEa2SE2+RTGEDYJRSYUxie2oNn9
         qpyYMfb2Szge6fb9XMoZNjKA+tt9rBXMvFy5iEjmvHWnTDiaP+xn4RL94L+23QeiwK1u
         yiszkz8P6+HlH/3Vkd1Vgoxn3HZO3V0JAwjbtMVo29wmGA3sQ0GjLfKQ/kP7PE6K5dAN
         ODJw==
X-Gm-Message-State: ACrzQf2xHkBi5kf+QDXkpAW6uJoxwFmT8nvlBYSgtygLUXQ0R70UYVUi
        IG2ZlHf2WshiF+FWfPKHXveb5aa9UkQn/3MGQxJyNkotN6BjXHMREOFqJudzUCQOofSnicoxYsa
        xJjJHoAaSsFfQi3uKg7JQCA==
X-Received: by 2002:a5d:6589:0:b0:236:52af:3b70 with SMTP id q9-20020a5d6589000000b0023652af3b70mr37673585wru.349.1668014901230;
        Wed, 09 Nov 2022 09:28:21 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7X19OUH83gjS/DNM/0Z+6JG2EeYstuDpWUj7N0q8JkMcyNof68t4OpVEOqfNvS1GhfB2RYFw==
X-Received: by 2002:a5d:6589:0:b0:236:52af:3b70 with SMTP id q9-20020a5d6589000000b0023652af3b70mr37673577wru.349.1668014901019;
        Wed, 09 Nov 2022 09:28:21 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id t12-20020a5d6a4c000000b00228692033dcsm13744245wrw.91.2022.11.09.09.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 09:28:20 -0800 (PST)
Message-ID: <e65197ac-9f42-77d4-76dc-0d1b1c5b1a9e@redhat.com>
Date:   Wed, 9 Nov 2022 18:28:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [GIT PULL 0/2] s390 fixes for 6.1-rc5
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com
References: <20221107094329.81054-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221107094329.81054-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/7/22 10:43, Janosch Frank wrote:
>    https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-6.1-1

Pulled, thanks.

Paolo

