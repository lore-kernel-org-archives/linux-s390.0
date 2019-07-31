Return-Path: <linux-kselftest-owner@vger.kernel.org>
Subject: Re: [PATCH 1/2] KVM: selftests: Implement ucall() for s390x
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-2-thuth@redhat.com>
 <20190730104807.7uzuvd52foybakgu@kamzik.brq.redhat.com>
 <d9cb3c86-6390-3803-f2c6-d47f5c24139f@redhat.com>
 <20190731102849.x26rdan7cddmpvhe@kamzik.brq.redhat.com>
 <0c38beb7-7383-a7ac-13d4-9d4bde4a21bb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7a103fa-51ef-533d-d3a4-7764fb742e44@redhat.com>
Date: Wed, 31 Jul 2019 14:57:38 +0200
MIME-Version: 1.0
In-Reply-To: <0c38beb7-7383-a7ac-13d4-9d4bde4a21bb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>

On 31/07/19 13:16, Thomas Huth wrote:
> Or maybe even better: Let's move this file into lib/x86_64/ and
> lib/aarch64/ instead, since there is more different code between the
> architectures here than common code.

All good solutions, just choose one. :))

Paolo
