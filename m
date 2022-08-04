Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDA0C25B08
	for <linux-s390@archiver.kernel.org>; Thu,  4 Aug 2022 22:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiHDWW6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiHDWWk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Aug 2022 18:22:40 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFA2C79
        for <linux-s390@vger.kernel.org>; Thu,  4 Aug 2022 15:22:35 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i4so949535oif.2
        for <linux-s390@vger.kernel.org>; Thu, 04 Aug 2022 15:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=GECmY1dAcGSZ5uG5VGKt6oVgDl5YDffKjX41m7A40aw=;
        b=lHkVI2GMFDc16SH/m/COAyecN8W5D0e+ocoAFc/tAkWckDKzIw1BdLLAAMD6dd0oin
         V+v5TcFjmzelxa+gfNhJx6QgM5IpfSVGwCH7LlUsZC2nAv4mvsqg7X4R0SbmZYXz3chn
         66TLr1IMiqKU7wxL1jRGZA7h18JMCRkv1KL9Vo6lSwVY9ts2CagOSx9xJ3VpVBmncoh9
         jb7w9yBDDhTHzPMtXBxLBRFxKRP6c34PFCji0H7LrzVAzBF4N/85IPq4k92aT8A9usFS
         hx2SExmNPzP7UWINUFJpL9WSRKsBmPkg5YnsCVmwcH/hT0IeiRgSaZPmF0J6d8zupkSF
         4ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GECmY1dAcGSZ5uG5VGKt6oVgDl5YDffKjX41m7A40aw=;
        b=H8i1GuEfH5GxkCV+D8ZW1IL3k8OmKJ36ote8BpYdNCjdURrESIPAp1k0wnyyApwZyo
         zSvnCZlsMfuKEqs5KpQSgDWz6ERAnbo/804uPyts01h/yUeL96+NFegy7CMWa2GxZpKW
         bAfrv/b/bJ0aL7HSaqHPR5HDx1iINjOuwnC9fY1qHmrLLjDxGggp8LSNGPmv2PQYIviJ
         /iq+m4Z6gXPq3rfWKy+Cb/IuuxZVhNxKtRpzL/4VeDbcQz3ImuM3Qi/N1JkJROJjzVML
         tG5jxCJff2VJJ0SdfYecUYZ+rn7fzldQ+CJn6OYb3Xx5r/56giD4ZditATTGxyzoID2w
         bIzw==
X-Gm-Message-State: ACgBeo06hmSK5SFLEasEx8Mvnjma2EzyNbThp3iH3OH30wcNj//zFQHM
        olRQp6kpB7cLYGQnD+SyeQIJdbM37oSFIQ==
X-Google-Smtp-Source: AA6agR7Uj/mi+l2ypnde/ze3YpSDhKnFkuTqw4zKwll4+h6bJwJd/xkCJnIWNtcXnfao1b2enWvU8w==
X-Received: by 2002:a17:90b:4b4d:b0:1f5:164f:f7c4 with SMTP id mi13-20020a17090b4b4d00b001f5164ff7c4mr12844803pjb.131.1659651743644;
        Thu, 04 Aug 2022 15:22:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:765b:12ab:9b40:fadd:2785:d5f6])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902cad100b0016d9d6d05f7sm1383126pld.273.2022.08.04.15.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:22:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     sth@linux.ibm.com
Cc:     linux-block@vger.kernel.org, jiangjian@cdjrlc.com,
        gor@linux.ibm.com,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        hca@linux.ibm.com, farman@linux.ibm.com, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org
In-Reply-To: <20220804213926.3361574-1-sth@linux.ibm.com>
References: <20220804213926.3361574-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/dasd: fix DMA alignment
Message-Id: <165965174157.108606.10811386647503961002.b4-ty@kernel.dk>
Date:   Thu, 04 Aug 2022 16:22:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 4 Aug 2022 23:39:24 +0200, Stefan Haberland wrote:
> please apply the following patches.
> The first fixes a comment typo and the second fixes DMA alignment after
> a change to the iomap code.
> 
> Eric Farman (1):
>   s390/dasd: Establish DMA alignment
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: drop unexpected word 'for' in comments
      commit: bcee43dc6d5bd6f54e5e2a5d696bf8c8f4c141dd
[2/2] s390/dasd: Establish DMA alignment
      commit: bc792884b76f0da2f5c9a8d720e430e2de9756f5

Best regards,
-- 
Jens Axboe


