From: Daniel Borkmann <borkmann@iogearbox.net>
Subject: Re: [PATCH] test_bpf: flag tests that cannot be jited on s390
Date: Fri, 29 Jun 2018 00:01:17 +0200
Message-ID: <ef715648-71a5-1d2c-581c-8bb32c94517c@iogearbox.net>
References: <20180627151921.15018-1-kleber.souza@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180627151921.15018-1-kleber.souza@canonical.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Kleber Sacilotto de Souza <kleber.souza@canonical.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 06/27/2018 05:19 PM, Kleber Sacilotto de Souza wrote:
> Flag with FLAG_EXPECTED_FAIL the BPF_MAXINSNS tests that cannot be jited
> on s390 because they exceed BPF_SIZE_MAX and fail when
> CONFIG_BPF_JIT_ALWAYS_ON is set. Also set .expected_errcode to -ENOTSUPP
> so the tests pass in that case.
> 
> Signed-off-by: Kleber Sacilotto de Souza <kleber.souza@canonical.com>

Applied to bpf, thanks Kleber!
