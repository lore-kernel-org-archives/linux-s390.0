Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160211153255.GR24726@rric.localdomain>
References: <1454407763-1017-1-git-send-email-gkulkarni@caviumnetworks.com>
	<1454407763-1017-4-git-send-email-gkulkarni@caviumnetworks.com>
	<CAL_JsqK5HV9yzBE+ANnTw26eVR7Dy+B8OkwQ-7WF8KDa86Fd9g@mail.gmail.com>
	<20160211153255.GR24726@rric.localdomain>
Date: Thu, 11 Feb 2016 21:28:01 +0530
Message-ID: <CAFpQJXU+fon8DY--qhyZV=JDv9omqs=c9eSX34g1J2w2uudNKA@mail.gmail.com>
Subject: Re: [PATCH v10 3/8] dt, numa: adding numa dt binding implementation.
From: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160211155801.dAE3x29mBNK5xQTFhdsJqSOvR8Qnv7vJjY04_nMMqRY@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: Rob Herring <robh+dt@kernel.org>, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-ia64@vger.kernel.org, linux-metag <linux-metag@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, rfranz@cavium.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Salter <msalter@redhat.com>, Steve Capper <steve.capper@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Tony Luck <tony.luck@intel.com>, fenghua.yu@intel.com, James Hogan <james.hogan@imgtec.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Jon Masters <jonathan@jonmasters.org>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, David Daney <ddaney@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Rob,

On Thu, Feb 11, 2016 at 9:02 PM, Robert Richter
<robert.richter@caviumnetworks.com> wrote:
> On 11.02.16 08:50:41, Rob Herring wrote:
>> On Tue, Feb 2, 2016 at 4:09 AM, Ganapatrao Kulkarni
>> <gkulkarni@caviumnetworks.com> wrote:
>> > dt node parsing for numa topology is done using device property
>> > numa-node-id and device node distance-map.
>>
>> How is it that powerpc doesn't need flat DT parsing for NUMA? Both
>> arches are memblock based and the binding is similar IIRC, so you
>> should be able to find a way to do this with the unflattened tree.
>> Ideally, there should be some common code shared as well.

powerpc has implemented numa binding using property named
"ibm,associativity", we too started adding using the same binding[
refer version V6]
however had discussion/review with Mark R about mapping and we could not map to
some of the topology like mesh and ring topology.

So we have defined and implemented this new binding which is simple
and scalable.
This binding is very much aligned to ACPI NUMA specification.

>>
>> Do you have a git tree with this series?
>
> I have pushed it here for you:
>
>  https://git.kernel.org/cgit/linux/kernel/git/rric/linux.git/log/?h=thunder/numa-v10

thanks Robert.
>
> -Robert

thanks
Ganapat
