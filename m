Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBAAC41513
	for <linux-s390@archiver.kernel.org>; Mon, 14 Aug 2023 15:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjHNPAX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Aug 2023 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjHNPAB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Aug 2023 11:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A36018F
        for <linux-s390@vger.kernel.org>; Mon, 14 Aug 2023 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692025154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PX5RmphpSdOfbk2K2Sd9q25Z+mtzc0pzEohs+ykWn2k=;
        b=cb7dALpMMA5nwrEi5CyQz+Swc+QsNUuHonOMafW15sQsDpQl/APN2hurqUVgtJmWq1SrK5
        1BHnmaBQzLs7uilpRZON+a70a7NUD57IWSX4xZ3uUv0vfdrjQPg5paiMwkaffaZRM+RDIP
        6fUbVGETthoDQw6DM9ckiOrtDYEs4HM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-pmKSPnwzNweec9RQqWWFNw-1; Mon, 14 Aug 2023 10:59:12 -0400
X-MC-Unique: pmKSPnwzNweec9RQqWWFNw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe4f953070so28049755e9.2
        for <linux-s390@vger.kernel.org>; Mon, 14 Aug 2023 07:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025152; x=1692629952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PX5RmphpSdOfbk2K2Sd9q25Z+mtzc0pzEohs+ykWn2k=;
        b=W5ArViDGWpTdpfxdLQeDqeV7arD7+VWJ1cxVNJYgTgHbsiuktZmXJmrlwXjiLdL+PU
         gBhvrix3xhPbg/FOrfTALvPztZH8wbWH9ufC7df4x28p2iwMa6Il8ng7onHIj3p27+TY
         NKNeIX4EmmXvZdO86X6HK3Wv7H60z54ls13i7cGx6uG98coauXUTpSAOpWCTnfAqnvDi
         7/1d+8lskOOF+Jp3N1eSE1Hh7pq+EbPxfrquXVrifRmnTEYpldbe2hc1kd3mi2aAP/mV
         XSj1OHvZRTMdE42lfNjj1ybcQZ+OHpWVqBFEIVOMK6g3zEDMzdl6Y+Vov6g0cAa0jr6n
         p5nQ==
X-Gm-Message-State: AOJu0YwMdhRiUXdzjrfSG5++S4wxa36usqbtTR6XxYp4Ld45gWZApoUZ
        pcRxvWYyiuVlqctr5CAzm2LSZKu7RkFkWCXGu5zMmchX9ssd8IT7rbbjIH1U8RP9X0deQ3fi5WQ
        GHv6AIwFQUufSVIRMeQn15w==
X-Received: by 2002:a1c:7505:0:b0:3fc:4:a5b5 with SMTP id o5-20020a1c7505000000b003fc0004a5b5mr7695157wmc.29.1692025151839;
        Mon, 14 Aug 2023 07:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXhtEU7OH6zIeH7zxcfP8B0/f0QOOkIT4/d5tT8yH7q6bipjvSvsraUtRyo2ZU639VslbXGw==
X-Received: by 2002:a1c:7505:0:b0:3fc:4:a5b5 with SMTP id o5-20020a1c7505000000b003fc0004a5b5mr7695146wmc.29.1692025151588;
        Mon, 14 Aug 2023 07:59:11 -0700 (PDT)
Received: from [192.168.8.105] (dynamic-046-114-244-033.46.114.pool.telefonica.de. [46.114.244.33])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c229100b003fc01f7a42dsm9078115wmf.8.2023.08.14.07.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 07:59:11 -0700 (PDT)
Message-ID: <0fc509e0-7c58-fc97-45bc-319d126417c2@redhat.com>
Date:   Mon, 14 Aug 2023 16:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [kvm-unit-tests PATCH v5 6/6] s390x: add a test for SIE without
 MSO/MSL
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        David Hildenbrand <dhildenb@redhat.com>
References: <20230712114149.1291580-1-nrb@linux.ibm.com>
 <20230712114149.1291580-7-nrb@linux.ibm.com>
 <1aac769e-7523-a858-8286-35625bfb0145@redhat.com>
 <168932372015.12187.10530769865303760697@t14-nrb>
 <fd822214-ce34-41dd-d0b6-d43709803958@redhat.com>
 <168933116940.12187.12275217086609823396@t14-nrb>
 <000b74d7-0b4f-d2b5-81b4-747c99a2df42@redhat.com>
 <169087269702.10672.8933292419680416340@t14-nrb>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <169087269702.10672.8933292419680416340@t14-nrb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 01/08/2023 08.51, Nico Boehr wrote:
> Quoting Thomas Huth (2023-07-14 12:52:59)
> [...]
>> Maybe add $(SRCDIR)/s390x to INCLUDE_PATHS in the s390x/Makefile ?
> 
> Yeah, that would work, but do we want that? I'd assume that it is a
> concious decision not to have tests depend on one another.

IMHO this would still be OK ... Janosch, Claudio, what's your opinion on this?

  Thomas

