Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBD3C6379F
	for <linux-s390@archiver.kernel.org>; Mon, 20 Feb 2023 11:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBTLWD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 20 Feb 2023 06:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjBTLWC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Feb 2023 06:22:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B826B524E
        for <linux-s390@vger.kernel.org>; Mon, 20 Feb 2023 03:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676892071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3eNuSXSMwT7K8lYDjXpFROOa9BiqxQfFrSmx+/FDJAs=;
        b=OZIU7j/rA0fuofYirYHr5s/0FS9B0tc+kbjeMiQ3T1o6mr53isq5d/LW2nZwV96AEFM4U0
        pdL7y+AiKqHsjdaRjTCefxYgaZnr3PA/dnI1CBmh3jKgJIb3IoCu344tEWTpFjALDB7Rnu
        /JP1v+/edAoBalyEtz9LrjG20sJVYEY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-ZmwkunW5Oi2TXVoTdYa9cA-1; Mon, 20 Feb 2023 06:21:10 -0500
X-MC-Unique: ZmwkunW5Oi2TXVoTdYa9cA-1
Received: by mail-wm1-f69.google.com with SMTP id z6-20020a7bc7c6000000b003e0107732f4so478046wmk.1
        for <linux-s390@vger.kernel.org>; Mon, 20 Feb 2023 03:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eNuSXSMwT7K8lYDjXpFROOa9BiqxQfFrSmx+/FDJAs=;
        b=uevoytdiG/3jEHMq7UgGF1Gi5+uvcXhrefx98Zf6fKHspXB2wW4k42dKndlBe3xIZI
         ENdr+q/jHZ1XCgQegHjDf1nXVW48fttov3hOUwsJmBSJgSi8to8iOG+uTa7v2NUIvh7V
         IZkhQAmKcOSlKCdHYmrQnIxRGvj9/PIDeGCZvEK6t1aw2kcMFom+819Gxu60HLnpelNi
         5rFqsjezFG8uOqEjw18lLrW37rpRHK9/og+7HbhKlfsmUO/BNgcyeJDNSV9Armz/xtAk
         QNlFpnynzJj/quwFcOnbU2Ju2pX8mbVgF4ye+OsYfCW5BHItFWe/KzEMQS60tXq6TAfy
         8nMQ==
X-Gm-Message-State: AO0yUKULHCBWT7NNihCZMo4dpuv3koG0a6W8etZLNbu2pQRAsoKsdytN
        b0egxbRM1rJhYrrpftwUioIwWj9WotkXtFh+VsxeG3j0TYFJh1NlqzghZKI9MuwisaGi/KpHErG
        3Y5yVzvMcTuTC2iJEvO8uHA==
X-Received: by 2002:a05:6000:1a4e:b0:2c6:e824:7a5e with SMTP id t14-20020a0560001a4e00b002c6e8247a5emr259022wry.34.1676892068740;
        Mon, 20 Feb 2023 03:21:08 -0800 (PST)
X-Google-Smtp-Source: AK7set/WJC9Q7hUrS58bH3mA5ByqoqAxQkNSmCC79TeRMp7NDC+620Q0QJhNyWI/4bL39eZvdvEA2Q==
X-Received: by 2002:a05:6000:1a4e:b0:2c6:e824:7a5e with SMTP id t14-20020a0560001a4e00b002c6e8247a5emr258956wry.34.1676892068356;
        Mon, 20 Feb 2023 03:21:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:8300:e519:4218:a8b5:5bec? (p200300cbc7058300e5194218a8b55bec.dip0.t-ipconnect.de. [2003:cb:c705:8300:e519:4218:a8b5:5bec])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcdef000000b003e21356bddcsm14270316wmj.33.2023.02.20.03.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:21:07 -0800 (PST)
Message-ID: <096f4fba-ec53-0035-02c2-0916833a43c2@redhat.com>
Date:   Mon, 20 Feb 2023 12:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 12/41] s390/mm: Introduce pmd_mkwrite_kernel()
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        debug@rivosinc.com
Cc:     linux-s390@vger.kernel.org
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-13-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230218211433.26859-13-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.02.23 22:14, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> One of these changes is to allow for pmd_mkwrite() to create different
> types of writable memory (the existing conventionally writable type and
> also the new shadow stack type). Future patches will convert pmd_mkwrite()
> to take a VMA in order to facilitate this, however there are places in the
> kernel where pmd_mkwrite() is called outside of the context of a VMA.
> These are for kernel memory. So create a new variant called
> pmd_mkwrite_kernel() and switch the kernel users over to it. Have
> pmd_mkwrite() and pmd_mkwrite_kernel() be the same for now. Future patches
> will introduce changes to make pmd_mkwrite() take a VMA.
> 
> Only do this for architectures that need it because they call pmd_mkwrite()
> in arch code without an associated VMA. Since it will only currently be
> used in arch code, so do not include it in arch_pgtable_helpers.rst.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 

Heh, that answers my question to patch #11

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

