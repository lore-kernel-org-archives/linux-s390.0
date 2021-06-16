Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480CFC48BE8
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 16:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ACCD6044F
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 16:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhFPRBd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Jun 2021 13:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230167AbhFPRB2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Jun 2021 13:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623862762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSaKm7Um2oPV0vgrRNxfNZveJ3Fyoig0t9ydKjDoicw=;
        b=QxEUHkGiBUpVxzpq65ZcQnl/CzdYDPgrOhNfDfy6W1t/i5HV+QH2f6jgh5GPjaoiPCs2aE
        S6Wj59FlR6TTaXPc7G7QTGQ7JKw64x+PqlkMzcXChwZloOf8222HQGYaZd91YO5/EeiZ5Z
        CPfG4pCjnJBQWJM4ByEH29yAu/Lpnec=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-WWNIWh75MCe_73CNxDsq3g-1; Wed, 16 Jun 2021 12:59:20 -0400
X-MC-Unique: WWNIWh75MCe_73CNxDsq3g-1
Received: by mail-ej1-f71.google.com with SMTP id jy19-20020a1709077633b02903eb7acdb38cso1201923ejc.14
        for <linux-s390@vger.kernel.org>; Wed, 16 Jun 2021 09:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CSaKm7Um2oPV0vgrRNxfNZveJ3Fyoig0t9ydKjDoicw=;
        b=a/RduxMVXAdi4yNyRPguD5RuFQWAQ5wXYEYQ3w9oyaGp0+/Q5StA0Ofpp1oG3JMWfL
         EwgM6VvNAlR+n5ofm6ihCbspg/sxx3to7qg7fv1HHd7Lp1LF62q3ykWadNXTGzqhxYDC
         fsM7eFT7a9WJxZ5PJHQSdMCW5dPNB8mkaaFwd6XjN94ASzAt3eqlAXo6Gdz6nIIymrWU
         AZjhyc2m2t+/0IG53wfCcu4g78K1Tr6yafIxeNDDLiVHVnb3qU7HLJLaVjjyHyy4t61e
         KalQLbaPfEkG2OUjbfGWlST/4b8QA7wmMCVHUS4sQswPV4TlABxoe3BPCob6VXKNmQGq
         pWsQ==
X-Gm-Message-State: AOAM5303VHdoRwpO1ktVXAsxcl6CuasDieSkvJ0ER4C9t3VnP18tAIQ5
        a3S/LIKGfQOLFGbWzryep860JKfRFP1+WNx6I8vWeaGcNM7/WohnmjXBqQ+H83s7rpyIDIP8e5u
        1HMpInNAEfsH1ut2NZ4Roig==
X-Received: by 2002:a17:906:5053:: with SMTP id e19mr483624ejk.251.1623862759028;
        Wed, 16 Jun 2021 09:59:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6Emn8wPqyvgKohGYGtUKYf4y4jrRKJJ2HFHwhTepqW0F8ugL/e9E7NezRGCz6vjrObsyEOg==
X-Received: by 2002:a17:906:5053:: with SMTP id e19mr483616ejk.251.1623862758801;
        Wed, 16 Jun 2021 09:59:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a3sm2208828edu.61.2021.06.16.09.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 09:59:17 -0700 (PDT)
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jing Zhang <jingzhangos@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
References: <20210614212155.1670777-1-jingzhangos@google.com>
 <20210614212155.1670777-4-jingzhangos@google.com>
 <YMoW7SBqO9EPgCXw@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v9 3/5] KVM: stats: Add documentation for statistics data
 binary interface
Message-ID: <9b9a951d-d020-5599-5c4f-e154b40522b9@redhat.com>
Date:   Wed, 16 Jun 2021 18:59:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMoW7SBqO9EPgCXw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16/06/21 17:21, Greg KH wrote:
> I forgot to comment on this one, sorry for the delay.
> 
> Why are you "inventing" your own schema format here for this?  Why not
> use a well-known or at least well-designed/implemented one that we have
> in userspace already?
> 
> There are a few that I would love to see in the kernel, varlink being
> the best example.  We have kernel examples of this and I would consider
> using that as a transport for sysfs-like data in the future, but never
> got around to it.

Thanks, that's a good observation, and it's a problem that the rationale 
and the design process didn't end up in either the documentation or the 
commit message (only the outcome did).  In order to fix that, this is 
going to be quite a long message.

Varlink comprises both a schema and an encoding, and each has its own 
problems.  For the encoding of the data, varlink is really just using 
JSON and it is really just the wrong tool here.  The first few problems 
that come to mind are:

- varlink structs are encoded as JSON dictionaries.  Therefore, every 
time userspace reads the fields, the kernel has to include the field 
names as JSON dictionary keys.  This means that a lot of time is spent 
writing buffers, and on the receiving side parsing them.

- because numeric data has to be converted to ASCII the output doesn't 
have fixed offsets, so it is not possible to make an efficient 
implementation of pread.

- even though Varlink specifies that int is "usually int64", a 
little-known gem is that JSON behavior for numbers not representable as 
a double (i.e. exceeding 2^53) is implementation-defined; 
implementations can and will mess up values outside that range.  This 
problem is not specific to this KVM stats usecase; varlink's schema 
specification really is at odds with its encoding specification.


For the schema, there are some specific problems with varlink, but also 
a more generic issue.  The specific problems are:

- the schema doesn't include the length of arrays.  This makes it hard 
to compute in advance lengths and offsets of fields (even ignoring the 
fact that data is not binary, which I'll get to later)

- the schema also is not extensible with user annotations.  In our case 
that would be mostly the unit in which the value is expressed.

The main problem with the various available serialization formats is 
that their schema languages are designed to be compiled with a code 
generator.  Here instead the schema is transmitted from the kernel to 
userspace.  Userspace is not really supposed to know what a value means 
or even that if it exists.  Userspace takes care of collecting the data 
from the kernel, but ultimately there will be a human that knows what 
e.g. "io_exits" or "req_event" means, and they will ask for the current 
value, or a plot over time, of a specific statistic.

Now, unlike most other schema languages, varlink does not require 
precompiling the schema in its C bindings.  However, this was mostly 
just the authors not bothering to write a C code generator---they did 
write one for Rust, for example.  When using the "official" varlink C 
bindings, you hardly use the schema at all.

Something similar to the above issues is quite common in other formats. 
  For example, FlatBuffers[2]'s schema language[1] does have annotations 
(which it calls metadata), but then we would still have to invent some 
standard annotations and teach programs about them.  However, the deal 
breaker is that again there is no way to transmit the schema from the 
server to the client, and that users are supposed to precompile the 
schema using a code generator.


All that said, what we _could_ do is serialize the schema as JSON 
instead of using a binary format, like so:

   [{
     "name": "exits",
     "kind": "cumulative",
     "count": 1
   }, {
     "name": "halt_poll_fail_ns",
     "kind": "cumulative",
     "unit": "seconds",
     "scale": {"base": "pow2", exponent: -9},
     "count": 1
   }, ...]

while keeping the actual statistics as an array of u64 values just like 
in these patches.  The JSON representation of the schema would be always 
the same, so it could be treated as fixed-size and an efficient 
implementation of pread would be possible.  And once the schema is JSON, 
there could be a *meta*-schema expressed using the varlink language:

   # compare to struct kvm_stats_desc, included after my sig
   # for reference
   type StatsDescriptor {
     name: string,
     kind: (cumulative, instant, peak),
     unit: ?(bytes, seconds, cycles),
     scale: ?(base: (pow2, pow10), exponent: int),
     count: int
   }

   type StatsSchema {
     name: string,
     stats: []StatsDescriptor
   }

Varlink would *not* be used in the kernel, because Varlink isreally 
just JSON.  The above ten lines (plus comments) would be dropped in 
Documentation/ as a .varlink file; they would be a convenient way to 
describe (to either a human or a program) how to parse the JSON schema.

There would then be another problem, namely how to include the varlink 
schema in the generated documentation, since right now there are for 
example no sphinx bindings for varlink.  Nevertheless, if you think it's 
better to have the schema as JSON instead of binary, according to the 
above varlink meta-schema, then we can look into it.

Thanks,

Paolo

>> +	struct kvm_stats_desc {
>> +		__u32 flags;
>> +		__s16 exponent;
>> +		__u16 size;
>> +		__u32 offset;
>> +		__u32 unused;
>> +		char name[0];
>> +	};

