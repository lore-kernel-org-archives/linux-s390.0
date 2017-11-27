From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 01/15] KVM: Prepare for moving vcpu_load/vcpu_put into
 arch specific code
Date: Mon, 27 Nov 2017 21:55:58 +0100
Message-ID: <ef5e2cad-9db2-b216-85fd-d56aa8f51a53@redhat.com>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <20171125205718.7731-2-christoffer.dall@linaro.org>
 <838db374-6040-c805-82f3-187a2cdfc40d@redhat.com>
 <20171127195830.GB16941@cbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171127195830.GB16941@cbox>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <cdall@linaro.org>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 27/11/2017 20:58, Christoffer Dall wrote:
> Going back and looking, it's nicer to avoid the pid adjustment call, and
> having vcpu_load be void is also convenient, but we're stuck with the
> ifdef.  I guess I lean towards your suggestion as well, given that my
> problem with the ifdef is not a technical one, but an aesthetic one.

Same here, so I think we're in agreement.

Paolo
